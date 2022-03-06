# app/spec/poros/forecast_spec.rb
require 'rails_helper'

RSpec.describe Forecast do
  before(:each) do
    @attributes = {:current_weather=>
      {:datetime=>"2022-03-06 17:44:13 -05:00",
        :sunrise=>"2022-03-06 06:22:24 -05:00",
        :sunset=>"2022-03-06 17:52:28 -05:00",
        :temp=>61.65,
        :feels_like=>60.75,
        :humidity=>69,
        :uvi=>0,
        :visibility=>10000,
        :conditions=>"clear sky",
        :icon=>"01d"},
      :daily_weather=>
      [{:date=>"2022-03-07 12:00:00 -05:00",
        :sunrise=>"2022-03-07 06:20:48 -05:00",
        :sunset=>"2022-03-07 17:53:34 -05:00",
        :max_temp=>68.85,
        :min_temp=>51.76,
        :conditions=>"heavy intensity rain",
        :icon=>"10d"},
        {:date=>"2022-03-08 12:00:00 -05:00",
        :sunrise=>"2022-03-08 06:19:12 -05:00",
        :sunset=>"2022-03-08 17:54:40 -05:00",
        :max_temp=>47.07,
        :min_temp=>36.64,
        :conditions=>"few clouds",
        :icon=>"02d"},
        {:date=>"2022-03-09 12:00:00 -05:00",
        :sunrise=>"2022-03-09 06:17:35 -05:00",
        :sunset=>"2022-03-09 17:55:46 -05:00",
        :max_temp=>43.81,
        :min_temp=>39.25,
        :conditions=>"light snow",
        :icon=>"13d"},
        {:date=>"2022-03-10 12:00:00 -05:00",
        :sunrise=>"2022-03-10 06:15:58 -05:00",
        :sunset=>"2022-03-10 17:56:51 -05:00",
        :max_temp=>47.39,
        :min_temp=>39.94,
        :conditions=>"light rain",
        :icon=>"10d"},
        {:date=>"2022-03-11 12:00:00 -05:00",
        :sunrise=>"2022-03-11 06:14:20 -05:00",
        :sunset=>"2022-03-11 17:57:56 -05:00",
        :max_temp=>44.8,
        :min_temp=>41.76,
        :conditions=>"light rain",
        :icon=>"10d"}],
      :hourly_weather=>
      [{:time=>"2022-03-06 18:00:00 -05:00", :temp=>61.65, :conditions=>"clear sky", :icon=>"01n"},
        {:time=>"2022-03-06 19:00:00 -05:00", :temp=>61.25, :conditions=>"few clouds", :icon=>"02n"},
        {:time=>"2022-03-06 20:00:00 -05:00", :temp=>60.84, :conditions=>"scattered clouds", :icon=>"03n"},
        {:time=>"2022-03-06 21:00:00 -05:00", :temp=>60.49, :conditions=>"broken clouds", :icon=>"04n"},
        {:time=>"2022-03-06 22:00:00 -05:00", :temp=>59.99, :conditions=>"broken clouds", :icon=>"04n"},
        {:time=>"2022-03-06 23:00:00 -05:00", :temp=>58.96, :conditions=>"overcast clouds", :icon=>"04n"},
        {:time=>"2022-03-07 00:00:00 -05:00", :temp=>58.39, :conditions=>"overcast clouds", :icon=>"04n"},
        {:time=>"2022-03-07 01:00:00 -05:00", :temp=>57.49, :conditions=>"overcast clouds", :icon=>"04n"}]}
      end

  it 'exists' do
    forecast = Forecast.new(@attributes)
    expect(forecast).to be_a(Forecast)
    expect(forecast.current_weather).to be_a(Hash)
    expect(forecast.current_weather[:conditions]).to eq('clear sky')
    expect(forecast.daily_weather[0][:conditions]).to eq('heavy intensity rain')
    expect(forecast.hourly_weather[1][:conditions]).to eq('few clouds')
  end
end
