class VersesController < NavigationController
  def show
    if params[:book] != nil then
      book_id = params[:book]
      if params[:chapter] != nil then
        chapter_name = params[:chapter]
        if params[:verse] != nil then
          verse_name = params[:verse]
          @verse = Verse.lookup(book_id, chapter_name, verse_name)
          @verse_text = VerseText.find(@verse.id)
          @chapter = @verse.chapter
          @book = @chapter.book
        end
      end
    else
      #this code could be factored to avoid duplication, but I want to make it easier to delete (soon)
      @verse = Verse.find(params[:id])  
      @verse_text = @verse.verse_text[0] #the default text for this verse
      @chapter = @verse.chapter
      @book = @chapter.book
    end
  end
  
  def random
    @verse = Verse.random
    @verse_text = VerseText.find(@verse.id)
    @chapter = @verse.chapter
    @book = @chapter.book
    verse_url = "/"+@book.name.to_s+"/"+@chapter.name.to_s+"/"+@verse.name.to_s
    redirect_to verse_url
  end
  
  def next
    navigation = get_navigation_from_session
    if navigation[:verse] != nil then
      verse_id = navigation[:verse]
      @verse = Verse.next(verse_id)
      
      @verse_text = VerseText.find(@verse.id)
      @chapter = @verse.chapter
      @book = @chapter.book
      verse_url = "/"+@book.name.to_s+"/"+@chapter.name.to_s+"/"+@verse.name.to_s
      redirect_to verse_url
    end
  end
  
  def prev
    navigation = get_navigation_from_session
    if navigation[:verse] != nil then
      verse_id = navigation[:verse]
      @verse = Verse.prev(verse_id)
      
      @verse_text = VerseText.find(@verse.id)
      @chapter = @verse.chapter
      @book = @chapter.book
      verse_url = "/"+@book.name.to_s+"/"+@chapter.name.to_s+"/"+@verse.name.to_s
      redirect_to verse_url
    end
  end

end
