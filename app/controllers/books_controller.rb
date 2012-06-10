class BooksController < NavigationController
  def show
    set_mode(:book)
    @book = Book.find(params[:id])
    @chapters = @book.chapters
    @chapter = @chapters[0]
    @verse = @chapter.verses[0]
  end
  
  def index
    @books = Book.all
  end
  
  def next
    set_direction(:next)
    navigation = get_navigation_from_session
    if navigation[:book] != nil then
      book_id = navigation[:book]
      @book = Book.next(book_id)
      @chapter = Chapter.lookup(book_id,chapter_name = -> {return  book_id == NUMBER_OF_BOOKS ? LAST_CHAPTER_NAME : 1}.call)
      #book_id == last, and not @book.islast, because we need to deal with the un-incremented book
      @verse = Verse.lookup(book_id,@chapter.name,verse_name = -> {return  @chapter.islast? ? LAST_VERSE_NAME : 1}.call)
      if params[:mode] != nil
        if params[:mode] == "chapter"
          chapter_url = "/"+@book.name.to_s.gsub(/ /,'')+"/"+@chapter.name.to_s
          redirect_to chapter_url
        elsif
           params[:mode] == "book"
            book_url = "/"+@book.name.to_s.gsub(/ /,'')
            redirect_to book_url
        end
      else
        @verse_text = VerseText.find(@verse.id)
        verse_url = "/"+@book.name.to_s.gsub(/ /,'')+"/"+@chapter.name.to_s+"/"+@verse.name.to_s
        redirect_to verse_url
      end
    end
  end
  
  def prev
    set_direction(:prev)
    navigation = get_navigation_from_session
    if navigation[:book] != nil then
      book_id = navigation[:book]
      @book = Book.prev(book_id)
      @chapter = Chapter.lookup(book_id,1)
      @verse = Verse.lookup(book_id,@chapter.name,1)
      if params[:mode] != nil
        if params[:mode] == "chapter"
          chapter_url = "/"+@book.name.to_s.gsub(/ /,'')+"/"+@chapter.name.to_s
          redirect_to chapter_url
        elsif
           params[:mode] == "book"
            book_url = "/"+@book.name.to_s.gsub(/ /,'')
            redirect_to book_url
        end
      else
        @verse_text = VerseText.find(@verse.id)
        verse_url = "/"+@book.name.to_s.gsub(/ /,'')+"/"+@chapter.name.to_s+"/"+@verse.name.to_s
        redirect_to verse_url
      end
    end
  end

end
