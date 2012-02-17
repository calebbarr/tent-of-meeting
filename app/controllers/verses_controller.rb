class VersesController < ApplicationController
  def show
    @verse = Verse.find(params[:id])  
    #the default text for this verse
    @verse_text = @verse.verse_text[0]
    puts @verse_text.content
    puts @verse.chapter_id
    @chapter = @verse.chapter
    @book = @chapter.book
  end

end
