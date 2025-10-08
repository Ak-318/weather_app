require 'rails_helper'

RSpec.describe WeatherService do
  describe '.get_forecast' do
    it 'returns forecast data structure' do
      forecast = WeatherService.get_forecast('Test Address')
      
      expect(forecast).to have_key(:current_temperature)
      expect(forecast).to have_key(:high_temperature)
      expect(forecast).to have_key(:low_temperature)
      expect(forecast).to have_key(:extended_forecast)
    end
  end
end