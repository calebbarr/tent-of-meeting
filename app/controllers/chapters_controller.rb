class ChaptersController < NavigationController
  
  def show
    set_mode(:chapter)
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
    store_navigation_in_session
  end
  
  def next
    set_direction(:next)
    navigation = get_navigation_from_session
    if navigation[:chapter] != nil then
      chapter_id = navigation[:chapter]
      @chapter = Chapter.next(chapter_id)
      @book = @chapter.book
      @verse = Verse.lookup(@book.id,@chapter.name, verse_name = -> {return  chapter_id == NUMBER_OF_CHAPTERS ? LAST_VERSE_NAME : 1}.call)
      ## chapter_id, not @chapter.id, because we want to know if the chapter was *already* last before being incremented
      if params[:mode] != nil
        if params[:mode] == "verse"
          @verse_text = VerseText.find(@verse.id)
          verse_url = "/"+@book.name.to_s.gsub(/ /,'')+"/"+@chapter.name.to_s+"/"+@verse.name.to_s
          redirect_to verse_url
        elsif params[:mode] == "chapter"
          chapter_url = "/"+@book.name.to_s.gsub(/ /,'')+"/"+@chapter.name.to_s
          redirect_to chapter_url
        elsif params[:mode] == "book"
          chapter_url = "/"+@book.name.to_s.gsub(/ /,'')+"/"+@chapter.name.to_s
          redirect_to chapter_url
        end
      else
        #else
        @verse_text = VerseText.find(@verse.id)
        verse_url = "/"+@book.name.to_s.gsub(/ /,'')+"/"+@chapter.name.to_s+"/"+@verse.name.to_s
        redirect_to verse_url
      end
    end
  end
  
  def prev
    set_direction(:prev)
    navigation = get_navigation_from_session
    if navigation[:chapter] != nil then
      chapter_id = navigation[:chapter]
      @chapter = Chapter.prev(chapter_id)
      @book = @chapter.book
      @verse = Verse.lookup(@book.id,@chapter.name,1)
      if params[:mode] != nil
        if params[:mode] == "verse"
          @verse_text = VerseText.find(@verse.id)
          verse_url = "/"+@book.name.to_s.gsub(/ /,'')+"/"+@chapter.name.to_s+"/"+@verse.name.to_s
          redirect_to verse_url
        elsif params[:mode] == "chapter"
          chapter_url = "/"+@book.name.to_s.gsub(/ /,'')+"/"+@chapter.name.to_s
          redirect_to chapter_url
        elsif params[:mode] == "book"
          chapter_url = "/"+@book.name.to_s.gsub(/ /,'')+"/"+@chapter.name.to_s
          redirect_to chapter_url          
        end
      else
        @verse_text = VerseText.find(@verse.id)
        verse_url = "/"+@book.name.to_s.gsub(/ /,'')+"/"+@chapter.name.to_s+"/"+@verse.name.to_s
        redirect_to verse_url
      end
    end
  end
  
  def current
    if @verse == nil
      @verse = Verse.find(session[:navigation][:verse])
    end
    @chapter = @verse.chapter
    @book = @chapter.book
    redirect_to @chapter.path+"#"+@verse.name.to_s
  end
  
  def set_current
    @response = "ok so far!"
    if params[:id] != nil then      
      @response = {}
      id = params[:id]
      @chapter = Chapter.find(id)
      @book = @chapter.book
      @verse = Verse.lookup(@book.id,@chapter.name,1)
      @response[:link] = @verse.link #response is for verse stuff
      @response[:id] = @verse.id
      session[:navigation][:chapter] = id
      session[:navigation][:verse] = @verse.id
      session[:navigation][:book] = @book.id
      respond_to do |format|
        format.json { render json: @response }
      end
      
    end
  end

end
