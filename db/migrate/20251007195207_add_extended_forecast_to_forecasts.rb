class AddExtendedForecastToForecasts < ActiveRecord::Migration[8.0]
  def change
    add_column :forecasts, :extended_forecast, :json
  end
end
