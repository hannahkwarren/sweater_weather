# app/poros/road_trip.rb

class RoadTrip
  attr_reader :start_city, :end_city, :travel_time, :weather_at_eta

  def initialize(attributes)
    @start_city = attributes[:start_city]
    @end_city = attributes[:end_city]
    @travel_time = calculate_travel_time(attributes[:travel_time])
    @weather_at_eta = attributes[:weather_at_eta]
  end

  def calculate_travel_time(time)
    calc = (time.to_f / 3600).round(2)
  end
end
