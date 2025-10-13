# WeatherService to fetch weather data from API or use mock data
class WeatherService
  # using https://openweathermap.org/ for real API calls
  # based on this api forming the request and response
  BASE_URL = ENV["BASE_WEATHER_URL"]

  def get_forecast(address)
    fetch_api_forecast(address)
  rescue => e
    Rails.logger.error("Weather API failed: #{e.message}. Using mock data.")
    fetch_mock_forecast_date(address)
  end

  private

  # fetch from real API for weather data
  def fetch_api_forecast(address)
    coordinates = get_coordinates(address)

    response = HTTParty.get("#{BASE_URL}/weather",
                query: {
                  lat: coordinates[:lat],
                  lon: coordinates[:lon],
                  appid: ENV["OPENWEATHER_API_KEY"],
                  units: "Metric"
                },
                timeout: 5
              )

    if response.success?
      parse_api_response(response, address)
    else
      raise "API Error: #{response.code} - #{response.message}"
    end
  end

  def get_coordinates(address)
    zip_code = GeocodingService.extract_zip_code(address)

    # mock coordinates for AP & TS cities
    coordinates_map = {
      "500001" => { lat: 17.3850, lon: 784867 }, # Hyderabad
      "500062" => { lat: 17.4948, lon: 78.3996 }, # Secunderabad
      "520001" => { lat: 16.5062, lon: 80.6480 }, # Vijayawada
      "530016" => { lat: 17.6868, lon: 83.2185 } # Visakhapatnam
    }

    coordinates_map[zip_code] || { lat: 17.6868, lon: 83.2185 } # Default to Visakhapatnam
  end

  def parse_api_response(response, address)
    data = JSON.parse(response.body)

    {
      current_temperature: data["main"]["temp"].round(1),
      high_temperature: data["main"]["temp_max"].round(1),
      low_temperature: data["main"]["temp_min"].round(1),
      extended_forecast: generate_extended_forecast,
      conditions: data["weather"].first["description"],
      address: address,
      humidity: data["main"]["humidity"],
      source: "API"
    }
  end

  # mock data for forecast
  def fetch_mock_forecast_date(address)
    sleep(0.5)

    {
      current_temperature: rand(20..40),
      high_temperature: rand(25..50),
      low_temperature: rand(10..25),
      extended_forecast: generate_extended_forecast,
      conditions: %w[Sunny Cloudy Rainy Windy].sample,
      address: address,
      humidity: rand(30..90),
      source: "Mock"
    }
  end

  def generate_extended_forecast
    (0..4).map do |day|
      {
        date: (Date.today + day).strftime("%Y-%m-%d"),
        high: rand(25..40),
        low: rand(10..25),
        conditions: %w[Sunny Cloudy Rainy Windy].sample
      }
    end
  end
end