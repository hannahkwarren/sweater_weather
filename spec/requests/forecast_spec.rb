# spec/requests/forecast_spec.rb

require 'rails_helper'
RSpec.describe 'Forecast API' do
  it 'returns a forecast for specified params location', :vcr do
    get '/api/v1/forecast?location=denver,co'

    expect(response).to be_successful
    expect(response.status).to eq(200)
    
    parsed = JSON.parse(response.body, symbolize_names: true)
    data = parsed[:data][:attributes]
    
    expect(data).to have_key(:current_weather)
    expect(data[:current_weather][:temp]).to eq(35.29)
    expect(data).to have_key(:daily_weather)
    expect(data[:daily_weather][0][:max_temp]).to eq(28.31)
    expect(data[:daily_weather][0][:min_temp]).to eq(16.97)
    expect(data).to have_key(:hourly_weather)
    expect(data[:hourly_weather][0][:temp]).to eq(35.29)
  end
end
