class VersesController < ApplicationController
  def show
    @verse = Verse.find(params[:id])  
    @verse_text = @verse.verse_text[0] #the default text for this verse
    @chapter = @verse.chapter
    @book = @chapter.book
  end

end
