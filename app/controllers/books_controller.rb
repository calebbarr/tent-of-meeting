class BooksController < ApplicationController
  def show
    @book = Book.find(params[:id])
    @chapters = @book.chapters
  end

end
