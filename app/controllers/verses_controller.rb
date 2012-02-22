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
      verse_url = "/"+@book.name.to_s.gsub(/ /,'')+"/"+@chapter.name.to_s+"/"+@verse.name.to_s
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
      verse_url = "/"+@book.name.to_s.gsub(/ /,'')+"/"+@chapter.name.to_s+"/"+@verse.name.to_s
      redirect_to verse_url
    end
  end

  def search
    if params[:query] != nil then
      @query = params[:query]
      @results =  VerseText.search(@query).page(params[:page])
    end
  end
  
end
