# app/services/forecast_service.rb
class ForecastService
  def self.maps_connection
    Faraday.new(url: 'http://www.mapquestapi.com/geocoding/v1/') do |faraday|
      faraday.params['key'] = ENV['mapquest_api_key']
      faraday.use Faraday::Response::RaiseError
    end
  end

  def self.geocoding_data(location)
    
    return 'Unable to access MapQuest Geocoding API.' if maps_connection.class != Faraday::Connection

    location_data = maps_connection.get('address') do |request|
      request.params['key'] = ENV['mapquest_api_key']
      request.params['location'] = location
    end

    JSON.parse(location_data.body, symbolize_names: true)
  end

  def self.parse_lat_lon(location)
    return 'Unable to access MapQuest Geocoding API.' if geocoding_data(location).nil?

    data = geocoding_data(location)
    { lat: data[:results][0][:locations][0][:latLng][:lat], lon: data[:results][0][:locations][0][:latLng][:lng] }
  end

  def self.weather_connection
    Faraday.new(url: 'https://api.openweathermap.org/data/2.5/') do |faraday|
      faraday.params['appid'] = ENV['weather_api_key']
    end
  end

  def self.forecast_data(location)
    return 'Unable to access OpenWeather API.' if weather_connection.class != Faraday::Connection

    loc = parse_lat_lon(location)

    forecast = weather_connection.get('onecall') do |request|
      request.params['appid'] = ENV['weather_api_key']
      request.params['lat'] = loc[:lat]
      request.params['lon'] = loc[:lon]
      request.params['exclude'] = 'minutely,alerts'
      request.params['units'] = 'imperial'
    end

    JSON.parse(forecast.body, symbolize_names: true)
  end
end
