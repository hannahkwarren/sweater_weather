# app/poros/forecast.rb
class Forecast
  attr_reader :id, :current_weather, :daily_weather, :hourly_weather

  def initialize(attributes)
    @current_weather = attributes[:current_weather]
    @daily_weather = attributes[:daily_weather]
    @hourly_weather = attributes[:hourly_weather]
  end
end
