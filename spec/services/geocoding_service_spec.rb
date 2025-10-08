require 'rails_helper'

RSpec.describe GeocodingService do
  describe '.extract_zip_code' do
    it 'extracts zip code from address with 6-digit zip' do
      address = "Visakhapatnam Port, Visakhapatnam, Andhra Pradesh 530014"
      expect(GeocodingService.extract_zip_code(address)).to eq('530014')
    end
    
    it 'extracts zip code from address with 10-digit zip' do
      address = "Visakhapatnam Port, Visakhapatnam, Andhra Pradesh 530014"
      expect(GeocodingService.extract_zip_code(address)).to eq('530014-1234')
    end
  end
end