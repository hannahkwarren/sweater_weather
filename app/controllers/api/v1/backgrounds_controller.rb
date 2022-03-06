# app/controllers/api/v1/backgrounds_controller.rb
class Api::V1::BackgroundsController < ApplicationController
  def show
    background = BackgroundFacade.get_image_details(params[:query])
  end
end
