# app/services/forecast_service.rb
class ForecastService
  def self.maps_connection
    Faraday.new(url: 'http://www.mapquestapi.com/geocoding/v1/') do |faraday|
      faraday.params['key'] = ENV['mapquest_api_key']
    end
  end

  def self.latitude_and_longitude(location)
    location_data = maps_connection.get('address') do |faraday|
      faraday.params['key'] = ENV['mapquest_api_key']
      faraday.params['location'] = location
    end
    JSON.parse(location_data.body, symbolize_names: true)
  end
end
