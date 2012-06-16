class VersesController < NavigationController
  
  def show
    set_mode(:verse)
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
            if @verse.ot? then
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
    @related_unpaged = @verse.related
    @related =  @verse.related.page(params[:page])
    @chapter = @verse.chapter
    @book = @chapter.book
    respond_to do |format|
      format.html
      format.json { 
        @results = []
        @related_unpaged.each do |related_verse|
          # maybe this is how languages can be done.  people
          # can rearrange their top N choices or something
          @results << {content: related_verse.verse_texts[0].content, path: related_verse.path.html_safe, link: related_verse.link}
        end
        render json: @results
        }
    end
  end
  
  def random
    set_direction(:random)
    @verse = Verse.random
    @verse_text = VerseText.find(@verse.id)
    @chapter = @verse.chapter
    @book = @chapter.book
    verse_path = "/"+@book.name.to_s.gsub(/\s+/, "")+"/"+@chapter.name.to_s+"/"+@verse.name.to_s
    redirect_to verse_path
  end
  
  def next
    set_direction(:next)
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
  
  def current
    if @verse == nil
      @verse = Verse.find(sessoion[:navigation][:verse])
    end
    redirect_to @verse.path
  end
  
  def prev
    set_direction(:prev)
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

  # @TODO
  # this is now starting to include all search functionality and
  # should be factored out of verses controller
  
  #@TODO debug... @result... @search_results
  def search
    set_mode(:search)
    @search_results = {:empty => true}
    if params[:query] != nil
      @query = params[:query]
    #   
      if is_number?(@query)
    #     # @TODO FINISH
        @search_results[:original_words] = []
      elsif is_englishish?(@query)
        @results = []
        @search_results[:verses] = [] if @search_results[:verses] == nil
        @search = VerseText.search do
          fulltext params[:query]
          order_by(:book_id, :asc)
          order_by(:chapter_id, :asc)
          order_by(:verse_id, :asc)
        end
        @results = @search.results
        @search_results[:verses] = @results
        if @results.length == 0 then
          @results = VerseText.regex_search(@query).page(params[:page])
          @search_results[:verses] =  @results
        end
        if @results.length > 0
          @search_results[:empty] = false
        end
      elsif is_hebrew?(@query)
          @search_results[:verses] = [] if @search_results[:verses] == nil
          #needs to come back with strongs entries, too, and display them
          @search = OTHebrewVerse.search do
            fulltext params[:query]
          end
          @results = @search.results
          @search_results[:verses] = @results
          if @results.length > 0
            @search_results[:empty] = false
          end
          @search = OTHebrewWord.search do
            fulltext params[:query]
          end
          @results = @search.results
          @search_results[:words] = @results
          if @results.length > 0
            @search_results[:empty] = false
          end
        elsif is_greek?(@query)
          @search_results[:verses] = [] if @search_results[:verses] == nil
          @search = NTGreekVerse.search do
            fulltext params[:query]
          end
          @results = @search.results
          @search_results[:verses] = @results
          if @results.length > 0
            @search_results[:empty] = false
          end
          @search = NTGreekWord.search do
            fulltext params[:query]
          end
          @results = @search.results
          @search_results[:words] = @results
          if @results.length > 0
            @search_results[:empty] = false
          end
    #     # @regex_results = NTGreekWord.regex_search(:query)
    #     # @results[:words] += @regex_results
    #     # @TODO the list concatenation doesn't seem to work
    #     # either make new dictionary key and corresponding view logic
    #     # once the regex search works, or figure out how to include it
      end
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
  
  def toggle_favorite
    if params[:id] != nil then
      verse_id = params[:id]
      if signed_in?
        if current_user.favorite?(verse_id) then
          Verse.unfavorite(current_user.id,verse_id)
          redirect_to @verse.path, notice: 'Favorite verse removed.'
        else
          FavoriteVerseRelationship.create(user_id: current_user.id, favorite_id: verse_id)
          redirect_to @verse.path, notice: 'Favorite verse added.'
        end
      else
        redirect_to @verse.path, notice: 'You need to be logged in to have favorite verses.'
      end
    end
  end
  
  def toggle_original_languages
    @response = "ok so far!"
    if params[:nt] != nil then
      if params[:nt] == "true" then
        if signed_in? then
          current_user.nt_lg = current_user.nt_lg == "eng"  ? "nt_grk" :  "eng"
          current_user.save
        else
          session[:nt_lg] == "eng" ? session[:nt_lg] = "nt_grk" : session[:nt_lg] =  "eng"
        end
        @response = "changed nt_lg"
      else
        if signed_in? then
          current_user.ot_lg = current_user.ot_lg == "eng" ? "ot_heb" :  "eng"
          current_user.save
        else
          session[:ot_lg] == "eng" ? session[:ot_lg] = "ot_heb" : session[:ot_lg] =  "eng"
        end
        @response = "changed ot_lg"
      end
    else
    end
    respond_to do |format|
      format.json { render json: @response}
    end 
  end
  
  def set_current
    @response = "ok so far!"
    if params[:id] != nil then      
      @response = {}
      id = params[:id]
      @verse = Verse.find(id)
      @chapter = @verse.chapter
      @book = @chapter.book
      @response[:link] = @verse.link
      @response[:id] = @verse.id
      session[:navigation][:verse] = id
      session[:navigation][:chapter] = @chapter.id
      session[:navigation][:book] = @book.id
      respond_to do |format|
        format.json { render json: @response }
      end
      
    end
  end
  
end