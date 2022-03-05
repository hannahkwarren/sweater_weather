# app/spec/services/forecast_service_spec.rb
require 'rails_helper'

RSpec.describe 'Forecast Service' do
  it 'returns latitude and longitude data from Mapquest Geocoding API' do
    location_data = ForecastService.latitude_and_longitude('Washington,DC')
    expect(location_data).to be_a Hash
    expect(location_data).to have_key(:results)
    expect(location_data[:results]).to be_an Array
    expect(location_data[:results][0]).to be_a Hash
    expect(location_data[:results][0][:locations]).to be_an Array
    expect(location_data[:results][0][:locations][0]).to be_an Hash
    expect(location_data[:results][0][:locations][0][:latLng]).to be_an Hash
    expect(location_data[:results][0][:locations][0][:latLng]).to have_key(:lat)
    expect(location_data[:results][0][:locations][0][:latLng]).to have_key(:lng)
    # response[:results][0][:locations][0][:latLng]
  end

  context 'edge case' do
    it 'returns latitude and longitude data even when location is typed strangely' do
      location_data = ForecastService.latitude_and_longitude('newyORK,ny')
      expect(location_data).to be_a Hash
      expect(location_data).to have_key(:results)
      expect(location_data[:results]).to be_an Array
      expect(location_data[:results][0]).to be_a Hash
      expect(location_data[:results][0][:locations]).to be_an Array
      expect(location_data[:results][0][:locations][0]).to be_an Hash
      expect(location_data[:results][0][:locations][0][:latLng]).to be_an Hash
      expect(location_data[:results][0][:locations][0][:latLng]).to have_key(:lat)
      expect(location_data[:results][0][:locations][0][:latLng]).to have_key(:lng)
      # response[:results][0][:locations][0][:latLng]
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
