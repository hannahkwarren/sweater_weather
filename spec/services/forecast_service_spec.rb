# app/spec/services/forecast_service_spec.rb
require 'rails_helper'

RSpec.describe 'Forecast Service' do
  context 'happy path, main use case' do
    it 'can establish a Faraday connection with the Mapquest API' do
      conn = ForecastService.maps_connection
      expect(conn).to be_a(Faraday::Connection)
    end

    it 'returns location data from Mapquest Geocoding API' do
      location_data = ForecastService.geocoding_data('Washington,DC')

      expect(location_data).to be_a Hash
      expect(location_data).to have_key(:results)
      expect(location_data[:results]).to be_an Array
      expect(location_data[:results][0]).to be_a Hash
      expect(location_data[:results][0][:locations]).to be_an Array
      expect(location_data[:results][0][:locations][0]).to be_an Hash
      expect(location_data[:results][0][:locations][0][:latLng]).to be_an Hash
      expect(location_data[:results][0][:locations][0][:latLng]).to have_key(:lat)
      expect(location_data[:results][0][:locations][0][:latLng]).to have_key(:lng)
    end

    it 'can parse latitude and longitude from location data' do
      lat_long = ForecastService.parse_lat_lon('Washington,DC')

      expect(lat_long).to be_a Hash
      expect(lat_long).to have_key(:lat)
      expect(lat_long).to have_key(:lon)
    end

    it 'can establish a Faraday connection with the OpenWeather API' do
      conn = ForecastService.weather_connection
      expect(conn).to be_a(Faraday::Connection)
    end

    it 'can get weather data from OpenWeather API' do
      loc = { :lat => 38.8920, :lon => -77.0199 }
      nyc_weather = ForecastService.forecast_data('Pittsburgh,PA')

      expect(nyc_weather).to be_a Hash
      expect(nyc_weather)
    end
  end
  
end

# {
#   "data": {
#     "id": null,
#     "type": "forecast",
#     "attributes": {
#       "current_weather": {
#         "datetime": "2020-09-30 13:27:03 -0600",
#         "temperature": 79.4,
#         etc
#       },
#       "daily_weather": [
#         {
#           "date": "2020-10-01",
#           "sunrise": "2020-10-01 06:10:43 -0600",
#           etc
#         },
#         {...} etc
#       ],
#       "hourly_weather": [
#         {
#           "time": "14:00:00",
#           "conditions": "cloudy with a chance of meatballs",
#           etc
#         },
#         {...} etc
#       ]
#     }
#   }
# }
