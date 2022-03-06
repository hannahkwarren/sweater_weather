# app/services/Background_service.rb
class BackgroundService
  def self.background_connection
    Faraday.new(url: 'https://api.unsplash.com/') do |faraday|
      faraday.params['client_id'] = ENV['unsplash_api_key']
    end
  end

  def self.background_image(query)
    return 'Unable to access Upsplash API.' if background_connection.class != Faraday::Connection

    response = background_connection.get('search/photos') do |request|
      request.params['client_id'] = ENV['unsplash_api_key']
      request.params['per_page'] = 1
      request.params['orientation'] = 'landscape'
      request.params['query'] = query
    end
    JSON.parse(response.body, symbolize_names: true)
  end
end
