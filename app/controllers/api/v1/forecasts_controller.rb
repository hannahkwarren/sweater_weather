# app/controllers/api/v1/forecasts_controller.rb
class Api::V1::ForecastsController < ApplicationController
  def show
    forecast = ForecastFacade.get_searched_forecast(params[:location])
    render json: ForecastSerializer.new(forecast)
  end
end
