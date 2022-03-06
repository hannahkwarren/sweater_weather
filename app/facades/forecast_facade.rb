# app/facades/forecast_facade.rb
class ForecastFacade
  def self.get_searched_forecast(location)
    @api_forecast = ForecastService.forecast_data(location)

    attributes = {
      current_weather: current_weather,
      daily_weather: daily_weather,
      hourly_weather: hourly_weather
    }

    Forecast.new(attributes)
  end

  def self.current_weather
    {
      datetime: Time.at(@api_forecast[:current][:dt]).strftime('%F %T %:z'),
      sunrise: Time.at(@api_forecast[:current][:sunrise]).strftime('%F %T %:z'),
      sunset: Time.at(@api_forecast[:current][:sunset]).strftime('%F %T %:z'),
      temp: @api_forecast[:current][:temp],
      feels_like: @api_forecast[:current][:feels_like],
      humidity: @api_forecast[:current][:humidity],
      uvi: @api_forecast[:current][:uvi],
      visibility: @api_forecast[:current][:visibility],
      conditions: @api_forecast[:current][:weather][0][:description],
      icon: @api_forecast[:current][:weather][0][:icon]
    }
  end

  def self.daily_weather
    daily_weather = []

    @api_forecast[:daily][1..5].each do |hash|
      daily_weather << {
        date: Time.at(hash[:dt]).strftime('%F %T %:z'),
        sunrise: Time.at(hash[:sunrise]).strftime('%F %T %:z'),
        sunset: Time.at(hash[:sunset]).strftime('%F %T %:z'),
        max_temp: hash[:temp][:max],
        min_temp: hash[:temp][:min],
        conditions: hash[:weather][0][:description],
        icon: hash[:weather][0][:icon]
      }
    end
    daily_weather
  end

  def self.hourly_weather
    hourly_weather = []

    @api_forecast[:hourly][1..8].each do |hash|
      hourly_weather << {
        time: Time.at(hash[:dt]).strftime('%F %T %:z'),
        temp: hash[:temp],
        conditions: hash[:weather][0][:description],
        icon: hash[:weather][0][:icon]
      }
    end
    hourly_weather
  end
end
