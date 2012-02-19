class ChaptersController < NavigationController
  def show
    if params[:book] != nil then
      book_id = params[:book]
      if params[:chapter] != nil then
        chapter_name = params[:chapter]
        @chapter = Chapter.lookup(book_id, chapter_name)
        @book = @chapter.book
        @verses = @chapter.verses
      end
    else
      #this code could be factored to avoid duplication, but I want to make it easier to delete (soon)
      @chapter = Chapter.find(params[:id])
      @book = @chapter.book
      @verses = @chapter.verses
    end
  end
  
  def next
    navigation = get_navigation_from_session
    if navigation[:chapter] != nil then
      chapter_id = navigation[:chapter]
      @chapter = Chapter.next(chapter_id)
      @book = @chapter.book
      @verse = Verse.lookup(@book.id,@chapter.name, verse_name = -> {return  chapter_id == NUMBER_OF_CHAPTERS ? LAST_VERSE_NAME : 1}.call)
      ## chapter_id, not @chapter.id, because we want to know if the chapter was *already* last before being incremented
      @verse_text = VerseText.find(@verse.id)
      verse_url = "/"+@book.name.to_s.gsub(/ /,'')+"/"+@chapter.name.to_s+"/"+@verse.name.to_s
      redirect_to verse_url
    end
  end
  
  def prev
    navigation = get_navigation_from_session
    if navigation[:chapter] != nil then
      chapter_id = navigation[:chapter]
      @chapter = Chapter.prev(chapter_id)
      @book = @chapter.book
      @verse = Verse.lookup(@book.id,@chapter.name,1)
      @verse_text = VerseText.find(@verse.id)
      verse_url = "/"+@book.name.to_s.gsub(/ /,'')+"/"+@chapter.name.to_s+"/"+@verse.name.to_s
      redirect_to verse_url
    end
  end

end
