class BooksController < NavigationController
  def show
    @book = Book.find(params[:id])
    @chapters = @book.chapters
  end
  
  def index
    @books = Book.all
  end
  
  def next
    navigation = get_navigation_from_session
    if navigation[:book] != nil then
      book_id = navigation[:book]
      @book = Book.next(book_id)
      @chapter = Chapter.lookup(book_id,1)
      @verse = Verse.lookup(book_id,@chapter.name,1)
      @verse_text = VerseText.find(@verse.id)
      verse_url = "/"+@book.name.to_s.gsub(/ /,'')+"/"+@chapter.name.to_s+"/"+@verse.name.to_s
      redirect_to verse_url
    end
  end
  
  def prev
    navigation = get_navigation_from_session
    if navigation[:book] != nil then
      book_id = navigation[:book]
      @book = Book.prev(book_id)
      @chapter = Chapter.lookup(book_id,1)
      @verse = Verse.lookup(book_id,@chapter.name,1)
      @verse_text = VerseText.find(@verse.id)
      verse_url = "/"+@book.name.to_s.gsub(/ /,'')+"/"+@chapter.name.to_s+"/"+@verse.name.to_s
      redirect_to verse_url
    end
  end

end
