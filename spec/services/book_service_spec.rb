# spec/services/book_service_spec.rb

require 'rails_helper'

RSpec.describe BookService do
  context 'connection' do
    it 'can connect with the Books API', :vcr do
      conn = BookService.book_connection
      expect(conn).to be_a(Faraday::Connection)
    end
  end

  context 'class methods' do
    it '::get_books', :vcr do
      response = BookService.get_books('Pittsburgh', 5)

      expect(response).to be_a(Hash)
      expect(response).to have_key(:numFound)
      expect(response).to have_key(:docs)
      expect(response[:docs]).to be_an(Array)
      expect(response[:docs][0]).to be_a(Hash)
      expect(response[:docs][0]).to have_key(:isbn)
      expect(response[:docs][0]).to have_key(:title)
      expect(response[:docs][0]).to have_key(:publisher)
    end
  end

  context 'sad path: user provides invalid quantity' do
    it '::get_books fails with a negative quantity' do
      response = BookService.get_books('Pittsburgh', -9)
      expect(response).to eq('Quantity must be a positive integer, provided this way: "&quantity=5"')
    end

    it '::get_books fails with a quantity string' do 
      response = BookService.get_books('Pittsburgh', 'five')
      expect(response).to eq('Quantity must be an integer, provided this way: "&quantity=5"')
    end
  end
end
