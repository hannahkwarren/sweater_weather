# app/controllers/api/v1/backgrounds_controller.rb
class Api::V1::BackgroundsController < ApplicationController
  def show
    background = BackgroundFacade.background(params[:location])
    # binding.pry
    render json: BackgroundSerializer.new(background)
  end
end
