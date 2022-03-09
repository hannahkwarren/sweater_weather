# app/facades/road_trip_facade.rb
class RoadTripFacade
  def self.roadtrip_data(origin, destination)
    api_data = RoadTripService.mapquest_time_duration(origin, destination)

    error_msg = api_data[:info][:messages][0]
    return error_msg if error_msg.instance_of? String

    @impt_data = {
                    dest_lat: api_data[:locations][1][:displayLatLng][:lat],
                    dest_lon: api_data[:locations][1][:displayLatLng][:lng],
                    travel_time: api_data[:time]
                  }
  end

  def self.hourly_forecast
    ForecastService.hourly_forecast_only(@impt_data[:dest_lat], @impt_data[:dest_lon])
  end

  def self.weather_at_eta
    hourly = hourly_forecast

    hours_in_future = ((@impt_data[:travel_time][1] / 3600).round - 1).to_i

    {
      temperature: hourly[:hourly][hours_in_future][:temp],
      conditions: hourly[:hourly][hours_in_future][:weather][0][:description]
    }
  end

  def self.roadtrip(origin, destination)
    roadtrip_cannot_compute = {
      start_city: origin,
      end_city: destination,
      travel_time: 'impossible',
      weather_at_eta: {}
    }

    return roadtrip_cannot_compute unless roadtrip_data(origin, destination).instance_of? Hash

    attributes = {
      start_city: origin,
      end_city: destination,
      travel_time: @impt_data[:travel_time],
      weather_at_eta: weather_at_eta
    }
    
    RoadTrip.new(attributes)
  end
end
