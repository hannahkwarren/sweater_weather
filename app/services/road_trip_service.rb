# app/services/road_trip_service.rb
class RoadTripService
  def self.directions_connection
    Faraday.new(url: 'http://www.mapquestapi.com/directions/v2/') do |faraday|
      faraday.params['key'] = ENV['mapquest_api_key']
      faraday.use Faraday::Response::RaiseError
    end
  end

  def self.mapquest_time_duration(origin, destination)
    return 'Unable to access MapQuest Directions API.' if directions_connection.class != Faraday::Connection

    response = directions_connection.post('routematrix') do |request|
      request.params['from'] = origin
      request.params['to'] = destination
    end

    JSON.parse(response.body, symbolize_names: true)
  end
end
