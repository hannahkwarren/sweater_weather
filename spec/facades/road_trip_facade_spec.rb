# app/spec/facades/road_trip_facade_spec.rb
require 'rails_helper'

RSpec.describe RoadTripFacade do
  context 'medium trip length' do
    let(:med_data) { RoadTripFacade.roadtrip_data('Pittsburgh, PA', 'Philadelphia, PA')}
    let(:med_hourly) { RoadTripFacade.hourly_forecast }

    it 'can get trip data from Service', :vcr do
      expect(med_data).to be_a Hash
      expect(med_data).to have_key(:dest_lat)
      expect(med_data).to have_key(:dest_lon)
      expect(med_data).to have_key(:travel_time)
    end

    it 'can get hourly forecast data from ForecastService', :vcr do
      expect(med_hourly).to be_a Hash
      expect(med_hourly).to have_key(:hourly)
    end

    it 'can get weather requisite hours in the future', :vcr do
      destination = RoadTripFacade.weather_at_eta
      expect(destination).to be_a Hash
      expect(destination).to have_key(:temperature)
      expect(destination).to have_key(:conditions)
    end

    it 'medium trip - can get final roadtrip data', :vcr do
      med_trip = RoadTripFacade.roadtrip('Pittsburgh, PA', 'Philadelphia, PA')

      expect(med_trip).to be_a RoadTrip
      expect(med_trip.start_city).to eq('Pittsburgh, PA')
      expect(med_trip.end_city).to eq('Philadelphia, PA')
      expect(med_trip.travel_time).to eq("4 hours, 40 minutes")
      expect(med_trip.weather_at_eta).to eq({:temperature=>37.53, :conditions=>"light rain"})
    end
  end

  context 'edge case: long trip length' do
    let(:long_trip) { RoadTripFacade.roadtrip('New York, NY', 'Los Angeles, CA') }

    it 'long trip - can get final roadtrip', :vcr do
      expect(long_trip).to be_a RoadTrip
      expect(long_trip.start_city).to eq('New York, NY')
      expect(long_trip.end_city).to eq('Los Angeles, CA')
      expect(long_trip.travel_time).to eq("40 hours, 42 minutes")
      expect(long_trip.weather_at_eta).to eq({:conditions=>"clear sky", :temperature=>58.51})
    end
  end

  context 'edge case: short trip length, less than 1 hour' do
    let(:short_trip) { RoadTripFacade.roadtrip('Pittsburgh, PA', 'New Kensington, PA') }

    it 'short trip - can get final roadtrip data', :vcr do
      expect(short_trip).to be_a RoadTrip
      expect(short_trip.start_city).to eq('Pittsburgh, PA')
      expect(short_trip.end_city).to eq('New Kensington, PA')
      expect(short_trip.travel_time).to eq("0 hours, 29 minutes")
      expect(short_trip.weather_at_eta).to eq(:conditions=>"overcast clouds", :temperature=>42.66)
    end
  end

  context 'edge case: impossible trip' do
    let(:impossible) { RoadTripFacade.roadtrip('New York, NY', 'London, UK') }

    it 'impossible', :vcr do
      expect(impossible).to be_a Hash
      expect(impossible[:start_city]).to eq('New York, NY')
      expect(impossible[:end_city]).to eq('London, UK')
      expect(impossible[:travel_time]).to eq('impossible')
      expect(impossible[:weather_at_eta]).to eq({})
    end
  end
end
