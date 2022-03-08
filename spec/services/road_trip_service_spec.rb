# app/spec/services/road_trip_service_spec.rb
require 'rails_helper'
RSpec.describe RoadTripService do
  context 'connections' do
    it 'can establish a connection with the MapQuest API', :vcr do
      conn = RoadTripService.directions_connection

      expect(conn).to be_a(Faraday::Connection)
    end
  end

  context 'request of MapQuest Directions API' do
    it 'can get distance and time data', :vcr do
      response = RoadTripService.mapquest_time_duration('Denver, CO', 'Los Angeles, CA')

      expect(response).to have_key(:distance)
      expect(response[:distance]).to be_an(Array)
      expect(response).to have_key(:locations)
      expect(response).to have_key(:time)
      expect(response[:time]).to be_an(Array)
    end
  end

  context 'sad path' do
    it 'produces error if Mapquest Directions API is down' do
      allow(RoadTripService).to receive(:directions_connection).and_return(double(Faraday::Response, status: 500, success?: false))

      expect(RoadTripService.mapquest_time_duration('Raleigh, NC', 'Asheville, NC')).to eq('Unable to access MapQuest Directions API.')
    end
  end
end
