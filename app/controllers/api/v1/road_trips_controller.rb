# app/controllers/api/v1/road_trips_controller.rb

class Api::V1::RoadTripsController < ApplicationController
  before_action :authenticate
  def show
    road_trip = RoadTripFacade.roadtrip(params[:origin], params[:destination])

    if road_trip.instance_of? RoadTrip
      render json: RoadTripSerializer.new(road_trip)
    else
      render json: { data: road_trip }
    end
  end

  private

  def authenticate
    User.find_by(private_api_key: params[:api_key]) || handle_bad_authentication
  end

  def handle_bad_authentication
    render json: { message: "Bad credentials" }, status: :unauthorized
  end
end
