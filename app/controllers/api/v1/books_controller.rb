# app/controllers/api/v1/books_controller.rb
class Api::V1::BooksController < ApplicationController
  def index
    books = BookFacade.location_books(params[:location], params[:quantity])
    # binding.pry
    serializer = BookSerializer.new(books)
    render json: serializer.book_search
  end
end
