# app/services/books_service.rb
class BookService
  def self.book_connection
    Faraday.new(url: 'http://openlibrary.org/')
  end

  def self.get_books(location, quantity)
    response = book_connection.get('/search.json') do |request|
      request.params['q'] = location
      request.params['subject'] = 'travel'
      request.params['published_in'] = '2010-2022'
      request.params['limit'] = quantity
    end
    JSON.parse(response.body, symbolize_names: true)
  end
end
