# app/services/books_service.rb
class BookService
  def self.book_connection
    Faraday.new(url: 'http://openlibrary.org/')
  end

  def self.get_books(location, quantity)
    response = book_connection.get('/search') do |request|
      request.params['q'] = location
      request.params['limit'] = quantity
      request.params['published_in'] = '2010-2022'
    end
  end
end