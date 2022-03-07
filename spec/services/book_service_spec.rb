# spec/services/book_service_spec.rb

require 'rails_helper'

RSpec.describe BookService do
  context 'connection' do
    it 'can connect with the Books API' do
      conn = BookService.book_connection
      expect(conn).to be_a(Faraday::Connection)
    end
  end

  context 'class methods' do
    it '::get_books' do
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
end
