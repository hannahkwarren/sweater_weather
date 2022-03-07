# spec/facades/book_facade_spec.rb
require 'rails_helper'
RSpec.describe BookFacade do
  it '::get_books_data', :vcr do
    books_api_data = BookFacade.get_books_data('Trenton', 5)
    expect(books_api_data).to be_a Hash
  end

  it '::current_forecast_data', :vcr do
    forecast_summary_info = BookFacade.current_forecast_data('Poughkeepsie,NY')
    expect(forecast_summary_info).to be_a Hash
  end

  it '::location_books', :vcr do
    books_response = BookFacade.location_books('Pittsburgh', 7)
    expect(books_response).to be_a Hash
    expect(books_response[:books]).to be_an Array
    expect(books_response[:books].count).to eq(7)
  end
end
