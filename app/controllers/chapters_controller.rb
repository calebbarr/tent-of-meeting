class ChaptersController < NavigationController
  def show
    if params[:book] != nil then
      book_id = params[:book]
      if params[:chapter] != nil then
        chapter_name = params[:chapter]
        @chapter = Chapter.lookup(book_id, chapter_name)
        @book = @chapter.book
        @verses = @chapter.verses
        @verse = @verses[0]
      end
    else
      #this code could be factored to avoid duplication, but I want to make it easier to delete (soon)
      @chapter = Chapter.find(params[:id])
      @book = @chapter.book
      @verses = @chapter.verses
      @verse = @verses[0]
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
  
  def current
    #im going to alter the navigation stuff in here
    #really, the assumptions of the stuff that handles the navigation stuff
    #should be correct, but this will force correct behavior
    
    #the reason this is different for 'verses', and actually plays well with the assumptions
    # made by the navigation handling code
    # is that the before_filter in the navigation code derives everything from the verse
    # so the verse just has to be set, and thats it
    # here, i am deriving everything from the chapter and hard coding it
    # some of the logic in the navigation code was intended to guard against errors 
    #need to review it and see whats still pertinent
    
    @response = "ok so far!"
    if params[:id] != nil then
      id = params[:id]
      @chapter = Chapter.find(id)
      @book = @chapter.book
      session[:chapter] = id
      @response = session[:navigation]
      session[:book] = @book.id
      @verse = Verse.lookup(@book.id,@chapter.name,1)
      session[:verse] = @verse.id
    end
    respond_to do |format|
      format.json { render json: @response}
    end    
  end

end
