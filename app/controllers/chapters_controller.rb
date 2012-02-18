class ChaptersController < ApplicationController
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

end
