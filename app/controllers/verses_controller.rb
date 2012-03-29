class VersesController < NavigationController
  def show
    if params[:book] != nil then
      book_id = params[:book]
      if params[:chapter] != nil then
        chapter_name = params[:chapter]
        if params[:verse] != nil then
          verse_name = params[:verse]
          @verse = Verse.lookup(book_id, chapter_name, verse_name)
          if signed_in? then
            @notes = @verse.notes_per_user(current_user.id)
            #not sure if this is best practice
            #may need to do some more database work
            session[:ot_lg] = nil
            session[:nt_lg] = nil
            #set language according to user's preference.
            if @verse.id < FIRST_NT_VERSE then
              if current_user.ot_lg == "eng" then
                @verse_text = VerseText.find(@verse.id).content
              elsif current_user.ot_lg == "ot_heb" then
                @verse_text = OriginalVerse.find(@verse.id).content
                @translations = OriginalVerse.find(@verse.id).translations.split("|")
                @strong_ids = OriginalVerse.find(@verse.id).strong_ids.split(" ")
              elsif current_user.ot_lg == nil then
                current_user.ot_lg = "eng"
                @verse_text = VerseText.find(@verse.id).content
              end
            else
                if current_user.nt_lg == "eng" then
                  @verse_text = VerseText.find(@verse.id).content
                elsif current_user.nt_lg == "nt_grk" then
                  @verse_text = OriginalVerse.find(@verse.id).content
                  @translations = OriginalVerse.find(@verse.id).translations.split("|")
                  @strong_ids = OriginalVerse.find(@verse.id).strong_ids.split(" ")
                elsif current_user.nt_lg == nil then
                  current_user.nt_lg = "eng"
                  @verse_text = VerseText.find(@verse.id).content
                end
            end
          else
            #we still want the user to be able to set preferences and such, but all this should be stored in the session
            if @verse.id < FIRST_NT_VERSE then
              if session[:ot_lg] != nil then
                if session[:ot_lg] == "ot_heb" then
                  @verse_text = OriginalVerse.find(@verse.id).content
                  @translations = OriginalVerse.find(@verse.id).translations.split("|")
                  @strong_ids = OriginalVerse.find(@verse.id).strong_ids.split(" ")
                elsif session[:ot_lg] == "eng" then
                  @verse_text = VerseText.find(@verse.id).content
                end
              else
                session[:ot_lg] = "eng"
                @verse_text = VerseText.find(@verse.id).content
              end
            else
              if session[:nt_lg] != nil then
                if session[:nt_lg] == "nt_grk" then
                  @verse_text = OriginalVerse.find(@verse.id).content
                  @translations = OriginalVerse.find(@verse.id).translations.split("|")
                  @strong_ids = OriginalVerse.find(@verse.id).strong_ids.split(" ")
                elsif session[:nt_lg] == "eng" then
                  @verse_text = VerseText.find(@verse.id).content
                end
              else
                session[:nt_lg] = "eng"
                @verse_text = VerseText.find(@verse.id).content
              end
            end
          end
          @chapter = @verse.chapter
          @book = @chapter.book
        end
      end
    end
  end
  
  def related
    @verse = Verse.find(params[:verse])
    @related =  @verse.related.page(params[:page])
    @chapter = @verse.chapter
    @book = @chapter.book
  end
  
  def random
    @verse = Verse.random
    @verse_text = VerseText.find(@verse.id)
    @chapter = @verse.chapter
    @book = @chapter.book
    verse_path = "/"+@book.name.to_s+"/"+@chapter.name.to_s+"/"+@verse.name.to_s
    redirect_to verse_path
  end
  
  def next
    navigation = get_navigation_from_session
    if navigation[:verse] != nil then
      verse_id = navigation[:verse]
      @verse = Verse.next(verse_id)
      
      @verse_text = VerseText.find(@verse.id)
      @chapter = @verse.chapter
      @book = @chapter.book
      verse_path = "/"+@book.name.to_s.gsub(/ /,'')+"/"+@chapter.name.to_s+"/"+@verse.name.to_s
      redirect_to verse_path
    end
  end
  
  def prev
    navigation = get_navigation_from_session
    if navigation[:verse] != nil then
      verse_id = navigation[:verse]
      @verse = Verse.prev(verse_id)
      
      @verse_text = VerseText.find(@verse.id)
      @chapter = @verse.chapter
      @book = @chapter.book
      verse_path = "/"+@book.name.to_s.gsub(/ /,'')+"/"+@chapter.name.to_s+"/"+@verse.name.to_s
      redirect_to verse_path
    end
  end

  def search
    if params[:query] != nil then
      @query = params[:query]
      @results =  VerseText.search(@query).page(params[:page])
    end
  end
  
  def add_favorite_verse
    if params[:id] != nil then
      verse_id = params[:id]
      if signed_in? then
        FavoriteVerseRelationship.create(user_id: current_user.id, favorite_id: verse_id)
      else
        #implement some session-based behavior for unauthenticated users
      end
      @verse = Verse.find(verse_id)
      @chapter = @verse.chapter
      @book = @chapter.book
      verse_path = "/"+@book.name.to_s.gsub(/ /,'')+"/"+@chapter.name.to_s+"/"+@verse.name.to_s
      redirect_to verse_path
    end
  end
  
  def remove_favorite_verse
    if params[:id] != nil then
      verse_id = params[:id]
      if signed_in? then
        Verse.unfavorite(current_user.id,verse_id)
      else
        #implement some session-based behavior for unauthenticated users
      end
      @verse = Verse.find(verse_id)
      @chapter = @verse.chapter
      @book = @chapter.book
      verse_path = "/"+@book.name.to_s.gsub(/ /,'')+"/"+@chapter.name.to_s+"/"+@verse.name.to_s
      redirect_to verse_path
    end
  end
  
  #should make functionality to return favorite verses *in* (book, chapter, NT, OT)
  def favorite_verses
    if signed_in?
      return User.get_favorite_verses(current_user.id)
    else
      #implement some session-based behavior for unauthenticated users
    end
  end
  
end