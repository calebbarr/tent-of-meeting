class VersesController < ApplicationController
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

end
