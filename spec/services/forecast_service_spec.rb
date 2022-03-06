# app/spec/services/forecast_service_spec.rb
require 'rails_helper'

RSpec.describe 'Forecast Service' do
  context 'happy path, Faraday connections' do
    it 'can establish a Faraday connection with the Mapquest API' do
      conn = ForecastService.maps_connection
      expect(conn).to be_a(Faraday::Connection)
    end

    it 'can establish a Faraday connection with the OpenWeather API' do
      conn = ForecastService.weather_connection
      expect(conn).to be_a(Faraday::Connection)
    end
  end

  context 'happy path, main use case' do
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

    it 'can get weather data from OpenWeather API' do
      nyc_weather = ForecastService.forecast_data('Pittsburgh,PA')

      expect(nyc_weather).to be_a Hash
      expect(nyc_weather)
    end
  end

  context 'sad path - external APIs down' do
    it 'returns message if the MapQuest API experiences an outage' do
      allow(ForecastService).to receive(:maps_connection).and_return(double(Faraday::Response, status: 500, success?: false))

      expect(ForecastService.geocoding_data('Pittsburgh,pa')).to eq('Unable to access MapQuest Geocoding API.')
    end

    it 'returns message if the OpenWeather API experiences an outage' do
      allow(ForecastService).to receive(:weather_connection).and_return(double(Faraday::Response, status: 500, success?: false))

      expect(ForecastService.forecast_data('Pittsburgh,pa')).to eq('Unable to access OpenWeather API.')
    end
  end
end
