FactoryBot.define do
  factory :forecast do
    zip_code { "MyString" }
    current_temperature { 1.5 }
    high_temperature { 1.5 }
    low_temperature { 1.5 }
    forecast_data { "" }
    cached { false }
  end
end
