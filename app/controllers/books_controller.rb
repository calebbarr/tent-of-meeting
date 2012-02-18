class BooksController < NavigationController
  def show
    @book = Book.find(params[:id])
    @chapters = @book.chapters
  end

end
