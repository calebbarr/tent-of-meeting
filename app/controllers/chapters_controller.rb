class ChaptersController < ApplicationController
  def show
    @chapter = Chapter.find(params[:id])
    @book = @chapter.book
    @verses = @chapter.verses
  end

end
