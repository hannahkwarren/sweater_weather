# spec/facades/book_facade_spec.rb
require 'rails_helper'
RSpec.describe BookFacade do

  it '::get_books_data' do
    books_api_data = BookFacade.get_books_data('Trenton')
    expect(books_api_data).to be_a Hash
  end

  it '::books_data_parse' do
    final_data = BookFacade.location_books('Philadelphia', 8)
    parsed = BookFacade.books_data_parse('Philadelphia', 8)
    expect(parsed).to be_a Hash
  end

  
end
