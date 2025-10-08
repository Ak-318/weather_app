# spec/models/forecast_spec.rb
require 'rails_helper'

RSpec.describe Forecast, type: :model do
  describe 'validations' do
    it 'validates presence of zip_code' do
      forecast = Forecast.new(zip_code: nil)
      expect(forecast).not_to be_valid
    end
    
    it 'validates format of zip_code' do
      forecast = Forecast.new(zip_code: '1234')
      expect(forecast).not_to be_valid
    end
  end
  
  describe '.for_address' do
    let(:address) { "Visakhapatnam Port, Visakhapatnam, Andhra Pradesh 530014" }
    
    it 'returns forecast for valid address' do
      forecast = Forecast.for_address(address)
      expect(forecast).to be_a(Forecast)
      expect(forecast.zip_code).to eq('530014')
    end
    
    it 'uses cached forecast when available' do
      # Create a recent forecast
      cached_forecast = create(:forecast,
        zip_code: '530014',
        updated_at: 10.minutes.ago
      )

      forecast = Forecast.for_address(address)
      expect(forecast.cached).to be true
    end
  end
end