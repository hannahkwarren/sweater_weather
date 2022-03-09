# app/spec/facades/road_trip_facade_spec.rb
require 'rails_helper'

RSpec.describe RoadTripFacade do
  context 'medium trip length' do
    let(:med_data) { RoadTripFacade.roadtrip_data('Pittsburgh, PA', 'Philadelphia, PA')}
    let(:med_hourly) { RoadTripFacade.hourly_forecast }

    it 'can get trip data from Service' do
      expect(med_data).to be_a Hash
      expect(med_data).to have_key(:dest_lat)
      expect(med_data).to have_key(:dest_lon)
      expect(med_data).to have_key(:travel_time)
    end

    it 'can get hourly forecast data from ForecastService' do
      expect(med_hourly).to be_a Hash
      expect(med_hourly).to have_key(:hourly)
    end

    it 'can get weather requisite hours in the future' do
      destination = RoadTripFacade.weather_at_eta
      expect(destination).to be_a Hash
      expect(destination).to have_key(:temperature)
      expect(destination).to have_key(:conditions)
    end

    it 'can get final roadtrip data' do
      med_trip = RoadTripFacade.roadtrip('Pittsburgh, PA', 'Philadelphia, PA')

      expect(med_trip).to be_a Hash
      expect(med_trip).to have_key(:start_city)
      expect(med_trip).to have_key(:end_city)
      expect(med_trip).to have_key(:travel_time)
      expect(med_trip).to have_key(:weather_at_eta)
    end
  end

  context 'edge case: long trip length' do
    let(:long_data) { RoadTripFacade.roadtrip('New York, NY', 'Los Angeles, CA') }

    it 'long trip - can get final roadtrip data' do
      expect(long_data).to be_a Hash
      expect(long_data).to have_key(:start_city)
      expect(long_data).to have_key(:end_city)
      expect(long_data).to have_key(:travel_time)
      expect(long_data).to have_key(:weather_at_eta)
    end
  end

  context 'edge case: short trip length, less than 1 hour' do
    let(:short_data) { RoadTripFacade.roadtrip('Pittsburgh, PA', 'New Kensington, PA') }

    it 'long trip - can get final roadtrip data' do
      expect(short_data).to be_a Hash
      expect(short_data).to have_key(:start_city)
      expect(short_data).to have_key(:end_city)
      expect(short_data).to have_key(:travel_time)
      expect(short_data).to have_key(:weather_at_eta)
    end
  end

  context 'edge case: impossible trip' do
    let(:impossible) { RoadTripFacade.roadtrip('New York, NY', 'London, UK') }

    it 'long trip - can get final roadtrip data' do
      expect(impossible).to be_a Hash
      expect(impossible).to have_key(:start_city)
      expect(impossible).to have_key(:end_city)
      expect(impossible).to have_key(:travel_time)
      expect(impossible[:travel_time]).to eq('impossible')
      expect(impossible).to have_key(:weather_at_eta)
      expect(impossible[:weather_at_eta]).to eq({})
    end
  end
  
end
