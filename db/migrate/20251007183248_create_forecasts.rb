class CreateForecasts < ActiveRecord::Migration[8.0]
  def change
    create_table :forecasts do |t|
      t.string :zip_code
      t.float :current_temperature
      t.float :high_temperature
      t.float :low_temperature
      t.json :forecast_data
      t.boolean :cached

      t.timestamps
    end
  end
end
