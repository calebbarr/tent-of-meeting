class NotesController < ApplicationController
  def new
    @note = Note.new
    @verse = Verse.find(params[:verse_id])
    @verse_text = VerseText.find(params[:verse_id])
  end

  def create
    @note = Note.new(params[:note])
    @verse = Verse.find(@note.verse_id)
    if @note.save then
      redirect_to @verse.path
    end
  end

  def index
  end

  def show
    @verse = Verse.find(params[:verse_id])
    @verse_text = VerseText.find(params[:verse_id])
    user_id = -> {signed_in? ? current_user.id : 1}.call
    # 1 is just a stand in for un-authenticated functionality
    @notes = @verse.notes_per_user(user_id)
  end
  
  def delete
    @note = Note.find(params[:id])
    @verse = Verse.find(@note.verse_id)
    if signed_in?
      if @note.user_id == current_user.id then
        Note.destroy(params[:id])
        redirect_to @verse.path, :notice => "note deleted."
      else
        redirect_to @verse.path, :notice => "you can only delete notes that belong to you."
      end
    else
      redirect_to @verse.path, :notice => "if you are the owner of this note, please log in to delete it."
    end
  end

end
