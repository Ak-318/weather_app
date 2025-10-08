class ForecastsController < ApplicationController
  def show
    address = forecast_params[:address]

    if address.present?
      @forecast = Forecast.for_address(address)
      if @forecast.nil?
        flash.now[:alert] = "Please enter an address from AP or Telangana with a zip code starting with 5."
      end
    else
      flash.now[:notice] = "Please enter an address to get weather forecast."
    end

  end

  private

  def forecast_params
    params.permit(:address)
  end

end