# app/services/books_service.rb
class BookService
  def self.book_connection
    Faraday.new(url: 'http://openlibrary.org/')
  end

  def self.get_books(location, quantity)
    return 'Unable to access Open Library API' if book_connection.class != Faraday::Connection
    warnings = user_input_warnings(location, quantity)
    if warnings.nil?
      response = book_connection.get('/search.json') do |request|
        request.params['q'] = location
        request.params['subject'] = 'travel'
        request.params['published_in'] = '2010-2022'
        request.params['limit'] = quantity
      end
    else
      return warnings
    end
    JSON.parse(response.body, symbolize_names: true)
  end

  def self.user_input_warnings(location, quantity)
    if quantity.class != Integer
      return 'Quantity must be an integer, provided this way: "&quantity=5"'
    elsif quantity.negative?
      return 'Quantity must be a positive integer, provided this way: "&quantity=5"'
    elsif location.class != String
      return 'Location must be a string'
    else
      return nil
    end
  end
end
