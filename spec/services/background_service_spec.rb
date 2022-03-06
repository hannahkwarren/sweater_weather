# app/spec/services/background_service_spec.rb

require 'rails_helper'

RSpec.describe BackgroundService do
  context 'connection to Upsplash API' do
    it 'can connect to Upsplash using Faraday' do
      conn = BackgroundService.background_connection

      expect(conn).to be_a(Faraday::Connection)
    end
  end

  context 'Happy Path: Upsplash /search/photos' do
    it 'can get an image object from Upsplash', :vcr do
      pic = BackgroundService.background_image('Portland,OR')

      expect(pic).to be_a(Hash)
      expect(pic).to have_key(:results)
      expect(pic[:results]).to be_an(Array)
      expect(pic[:results][0]).to be_a(Hash)
      expect(pic[:results][0]).to have_key(:id)
      expect(pic[:results][0]).to have_key(:alt_description)
      expect(pic[:results][0]).to have_key(:description)
      expect(pic[:results][0]).to have_key(:urls)
      expect(pic[:results][0][:urls]).to be_a(Hash)
      expect(pic[:results][0][:user]).to be_a(Hash)
    end
  end
end
