# app/spec/facades/forecast_facade_spec.rb
require 'rails_helper'

RSpec.describe ForecastFacade do
  it '::get_searched_forecast' do
    f = ForecastFacade.get_searched_forecast('Portland,OR')
    expect(f).to be_a(Forecast)
  end

  it '::get_forecast_data', :vcr do
    data = ForecastFacade.get_forecast_data('Cleveland,OH')
    expect(data).to be_a(Hash)
  end

  it '::current_weather', :vcr do
    current = ForecastFacade.current_weather
    expect(current).to be_a(Hash)
  end

  it '::daily_weather', :vcr do
    daily = ForecastFacade.daily_weather
    expect(daily).to be_an(Array)
  end

  it '::hourly_weather', :vcr do
    daily = ForecastFacade.hourly_weather
    expect(daily).to be_an(Array)
  end
end
