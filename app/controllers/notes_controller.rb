class NotesController < NavigationController
  def new
    @note = Note.new
    
    #assumes that if params[:verse_id] is empty, then the instance variable is already set
    # this parameter thing can probably go away as notes functionality gets shored up
    if params[:verse_id] != nil then
      @verse = Verse.find(params[:verse_id])
      @verse_text = VerseText.find(params[:verse_id])
    else
      @verse_text = VerseText.find(@verse.id)
    end
    
    respond_to do |format|
      format.html
      # format.json { render json: @verse_text}
    end
    
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
    if @notes.size < 1 then
      redirect_to new_note_path
    else
      respond_to do |format|
        format.html
        format.json { render json: @notes}
      end
    end
  end
  
  def delete
    @note = Note.find(params[:id])
    if signed_in?
      if @note.user_id == current_user.id then
        Note.destroy(params[:id])
        respond_to do |format|
          format.json { render json: "note " + params[:id] + " deleted" }
        end
      end
    end
  end
end
