# app/spec/facades/forecast_facade_spec.rb
require 'rails_helper'

RSpec.describe ForecastFacade do
  it '::get_searched_forecast' do
    f = ForecastFacade.get_searched_forecast('Portland,OR')

    expect(f).to be_a(Forecast)
  end

  context 'helper methods' do
    xit '::current_weather' do
      
      f = ForecastFacade.current_weather
    end
  end
end
