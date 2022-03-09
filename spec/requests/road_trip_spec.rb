# app/spec/requests/road_trip_spec.rb
require 'rails_helper'
RSpec.describe 'Road Trip endpoint' do
  context 'happy path: shorter road trip' do
    it 'can provide a travel time and weather upon arrival', :vcr do
      user1 = User.create(email: "test1@mail.com", password:"pass", password_confirmation: "pass")
      key = user1.private_api_key

      json_payload = {
        "origin": "New York, NY",
        "destination": "Burlington, VT",
        "api_key": key.to_s
      }

      post '/api/v1/road_trip', params: json_payload

      expect(response).to be_successful
      parsed = JSON.parse(response.body, symbolize_names: true)

      expect(parsed[:data][:type]).to eq('roadtrip')
      expect(parsed[:data][:attributes][:travel_time]).to eq('5 hours, 47 minutes')
      expect(parsed[:data][:attributes][:weather_at_eta]).to eq({ "temperature": 24.22, "conditions": "broken clouds" })
    end
  end

  context 'happy path: long (up to 40 hours) road trip' do
    it 'can provide travel time and weather upon arrival - long trips', :vcr do
      user2 = User.create(email: "test2@mail.com", password:"pass", password_confirmation: "pass")
      key = user2.private_api_key

      json_payload = {
        "origin": "New York, NY",
        "destination": "Los Angeles, CA",
        "api_key": key.to_s
      }

      post '/api/v1/road_trip', params: json_payload

      expect(response).to be_successful
      parsed = JSON.parse(response.body, symbolize_names: true)

      expect(parsed[:data][:type]).to eq('roadtrip')
      expect(parsed[:data][:attributes][:travel_time]).to eq('40 hours, 42 minutes')
      expect(parsed[:data][:attributes][:weather_at_eta]).to eq({ "temperature": 69.8, "conditions": "clear sky" })
    end
  end

  context 'sad path: impossible to drive' do
    it 'provides a message if a trip is impossible', :vcr do
      user3 = User.create(email: "test3@mail.com", password:"pass", password_confirmation: "pass")
      key = user3.private_api_key

      json_payload = {
        "origin": "New York, NY",
        "destination": "London, UK",
        "api_key": key.to_s
      }

      post '/api/v1/road_trip', params: json_payload

      expect(response).to be_successful
      parsed = JSON.parse(response.body, symbolize_names: true)
      expect(parsed[:data][:travel_time]).to eq('impossible')
    end
  end
end
