class MemorizeController < NavigationController
  def show
    if params[:book] != nil then
      book_id = params[:book]
      if params[:chapter] != nil then
        chapter_name = params[:chapter]
        if params[:verse] != nil then
          verse_name = params[:verse]
          @verse = Verse.lookup(book_id, chapter_name, verse_name)
          @verse_text = VerseText.find(@verse.id) #is this being resolved to .first later?
          #this should yield an array, for later when we implement multiple languages and versions
          @chapter = @verse.chapter
          @book = @chapter.book
        end
      end
    end
  end
  
  def next
    navigation = get_navigation_from_session
    if navigation[:verse] != nil then
      verse_id = navigation[:verse]
      verse = Verse.find(verse_id)
      chapter = verse.chapter
      book = chapter.book
      success = "Successfully memorized " + book.name.to_s + " " + chapter.name.to_s + ":" + verse.name.to_s
      @verse = Verse.next(verse_id)
      @verse_text = VerseText.find(@verse.id)
      @chapter = @verse.chapter
      @book = @chapter.book
      verse_path = "/"+@book.name.to_s.gsub(/ /,'')+"/"+@chapter.name.to_s+"/"+@verse.name.to_s+"/memorize"
      redirect_to verse_path, :notice => success
    end
  end

end
