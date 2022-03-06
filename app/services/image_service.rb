# app/services/image_service.rb
class ImageService
  def self.image_connection
    Faraday.new(url: 'https://api.unsplash.com/') do |faraday|
      faraday.params['client_id'] = ENV['unsplash_api_key']
    end
  end
end
