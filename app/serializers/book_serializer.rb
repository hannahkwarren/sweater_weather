# app/serializers/book_serializer.rb

class BookSerializer
  def initialize(books)
    @books = books
  end

  def book_search
    { "data": {
      "id": "null",
      "type": "books",
      "attributes": @books
    }
  }
  end
end
