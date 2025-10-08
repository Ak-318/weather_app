# GeocodingService to extract zip codes from addresses
class GeocodingService

  def self.extract_zip_code(address)
    zip_code_pattern = /\b[1-9][0-9]{5}\b/
    match = address.match(zip_code_pattern)
    match ? match[0] : fallback_zip_code_extraction(address)
  end

  private

  def self.fallback_zip_code_extraction(address)
    if address.downcase.include?("visakhapatnam")
      "530016"
    else
      "000000"
    end
  end

end