# app/controllers/api/v1/road_trips_controller.rb

class Api::V1::RoadTripsController < ApplicationController
  def show
    road_trip = RoadTripFacade.road_trip(origin, destination)

    render json: RoadTripSerializer.new(road_trip)
  end
end
