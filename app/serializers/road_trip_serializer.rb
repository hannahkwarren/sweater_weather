# app/serializers/road_trip_serializer.rb

class RoadTripSerializer
  include JSONAPI::Serializer
  set_id :id
  set_type :roadtrip
  attributes :start_city, :end_city, :weather_at_eta
end
