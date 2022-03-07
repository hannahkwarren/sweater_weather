# app/facades/book_facade.rb
class BookFacade
  def self.location_books(location, quantity)
    attributes = {
      destination: location,
      forecast: 
    }
  end

  def self.get_books_data(location, quantity)
    BookService.get_books(location, quantity)
  end

  def self.books_data_parse
    parsed_json = get_books_data

    { 
      destination: location, 

    }
  end

  def self.forecast_data
    ForecastFacade.
  end
end
