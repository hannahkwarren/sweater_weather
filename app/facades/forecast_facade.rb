# app/facades/forecast_facade.rb
class ForecastFacade
  def self.get_searched_forecast(location)
    api_forecast = ForecastService.forecast_data(location)
    binding.pry
    attributes = {
      current_weather:
        { 
          datetime: Time.at(api_forecast[:current][:dt]).to_datetime,
          sunrise: Time.at(api_forecast[:sunrise]).to_datetime,
          sunset: Time.at(api_forecast[:sunset]).to_datetime,
          temp: api_forecast[:temp],
          feels_like: api_forecast[:feels_like],
          humidity: api_forecast[:humidity],
          uvi: api_forecast[:uvi],
          visibility: api_forecast[:visibility],
          conditions: api_forecast[:weather][:description],
          icon: api_forecast[:weather][:icon]
        }
      }
      
  end
end
