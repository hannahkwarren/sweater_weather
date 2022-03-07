# app/facades/book_facade.rb
class BookFacade
  def self.location_books(location, quantity)
    parsed_json = get_books_data(location, quantity)

   x = {  destination: location,
          forecast: current_forecast_data(location),
          total_books_found: parsed_json[:numFound],
          books:
            parsed_json[:docs].each do |doc|
              { isbn: doc[:isbn],
                title: doc[:title],
                publisher: doc[:publisher] }
            end }
  end

  def self.get_books_data(location, quantity)
    # if quantity.class != Integer
    # end
    BookService.get_books(location, quantity)
  end

  def self.current_forecast_data(location)
    data = ForecastFacade.get_forecast_data(location)
    { summary: data[:current][:weather][0][:description],
      temperature: data[:current][:temp] }
  end
end
