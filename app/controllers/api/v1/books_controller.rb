# app/controllers/api/v1/books_controller.rb
class Api::V1::BooksController < ApplicationController
  def index 
    books = BookFacade.location_books(location, quantity = nil)

    render json: BookSerializer.new(books)
  end
end
