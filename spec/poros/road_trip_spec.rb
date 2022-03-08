# app/spec/poros/road_trip_spec.rb
require 'rails_helper'
RSpec.describe RoadTrip do
  it 'exists' do
    attributes = {
      start_city: 'Denver, CO',
      end_city: 'Boulder, CO',
      travel_time: 2240, 
      weather_at_eta: 'snow and sleet'
    }

    trip = RoadTrip.new(attributes)

    expect(trip).to be_a RoadTrip
    expect(trip.start_city).to eq('Denver, CO')
    expect(trip.end_city).to eq('Boulder, CO')
    expect(trip.travel_time).to eq(0.62)
    expect(trip.weather_at_eta).to eq('snow and sleet')
  end
end
