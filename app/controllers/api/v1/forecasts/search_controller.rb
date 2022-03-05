# app/controllers/api/v1/search_controller.rb
class Api::V1::Forecasts::SearchController < ApplicationController
  def index
    @weather = SearchFacade.weather_by_location(params[:location])
  end
end
