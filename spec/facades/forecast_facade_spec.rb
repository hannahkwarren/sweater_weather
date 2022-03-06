# app/spec/facades/forecast_facade_spec.rb
require 'rails_helper'

RSpec.describe 'Forecast Facade' do
  it 'can get searched forecast' do
    f = ForecastFacade.get_searched_forecast('Portland,OR')

    expect(f.attributes).to be_a Hash
  end

end
