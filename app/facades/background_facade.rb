# app/facades/background_facade.rb
class BackgroundFacade
  def self.get_image_data(query)
    BackgroundService.background_image(query)
  end

  def self.background(query)
    data = get_image_data(query)[:results][0]

    attributes = {
      'image': {
        'id': data[:id],
        'description': data[:description],
        'location': query,
        'urls': data[:urls],
        'credit': {
          'username': data[:user][:username],
          'first_name': data[:user][:first_name],
          'last_name': data[:user][:last_name],
          'bio': data[:user][:bio]
        }
      }
    }

    Background.new(attributes)
  end
end
