# Forecast model to store weather data

class Forecast < ApplicationRecord
  validates :zip_code, presence: true, format: { with: /\A[1-9][0-9]{5}\z/ }
  validates :current_temperature, :forecast_data, presence: true

  scope :recent, -> { where("updated_at >= ?", 30.minutes.ago) }

  attr_accessor :cached

  def self.for_address(address)
    zip_code = GeocodingService.extract_zip_code(address)
    return nil unless valid_zip?(zip_code)

    # finding cached forecast
    cached_forecast = recent.find_by(zip_code: zip_code)
    return mark_cached(cached_forecast) if cached_forecast

    # fetching fresh forecast
    fetch_fresh_forecast(address, zip_code)
  end

  private

  def self.valid_zip?(zip_code)
    zip_code.to_s.starts_with?("5")
  end

  def self.mark_cached(forecast)
    forecast.cached = true
    forecast
  end

  def self.fetch_fresh_forecast(address, zip_code)
    weather_data = WeatherService.new
    forecast_data = weather_data.get_forecast(address)
    return nil unless forecast_data.present?

    forecast = find_or_initialize_by(zip_code: zip_code)
    forecast.assign_attributes(
      current_temperature: forecast_data[:current_temperature],
      high_temperature: forecast_data[:high_temperature],
      low_temperature: forecast_data[:low_temperature],
      forecast_data: forecast_data,
      extended_forecast: forecast_data[:extended_forecast],
      cached: false
    )
    forecast.save!
    forecast
  end
end
