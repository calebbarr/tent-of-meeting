class NavigationController < ApplicationController
  before_filter :initialize_navigation
  # after_filter :store_navigation_in_session
  
 def initialize_navigation
   # just to make sure the hash is always there
   session[:navigation] = {:book => nil, :chapter => nil, :verse => nil, :direction => nil, :mode => nil}  if session[:navigation] == nil
 end
 
 def store_navigation_in_session  
  # clears location, not mode and direction
  if session[:navigation] == nil
     session[:navigation] = {:book => nil, :chapter => nil, :verse => nil}
  else
      session[:navigation][:book] = nil
      session[:navigation][:chapter] = nil
      session[:navigation][:verse] = nil
  end
  
   if @book == nil then
     @book = Book.find(1)
   end
   session[:navigation][:book] = @book.id
   if @chapter == nil then
     @chapter = Chapter.lookup(session[:navigation][:book], 1)
   end
   session[:navigation][:chapter] = @chapter.id
   if @verse == nil then
   @verse = Verse.lookup(@book.id,@chapter.name,1)
   end
   session[:navigation][:verse] = @verse.id
   
   # update verse current users
   update_current_verse_history_records
 end
 
 def update_current_verse_history_records
   if signed_in?
     if session[:navigation][:record_id] != nil
       old_record = VerseHistoryRecord.find(session[:navigation][:record_id])
       if old_record.verse_id == @verse.id
         old_record.updated_at = -> {Time.now}.call
         old_record.save
        else
          session[:navigation][:record_id] = VerseHistoryRecord.create(user_id: current_user.id, verse_id: @verse.id).id
        end
      else
        session[:navigation][:record_id] = VerseHistoryRecord.create(user_id: current_user.id, verse_id: @verse.id).id
      end
   # else
   #   VerseHistoryRecord.create(user_id: 1, verse_id: @verse.id) # @TODO stand-in for handling anonymous user
   end
 end
 
 def get_navigation_from_session
   return session[:navigation]
 end
 
 def set_mode(mode)
   session[:navigation][:mode] = mode
 end
 
 def set_direction(direction)
   session[:navigation][:direction] = direction
 end
 
 def clear_direction
   session[:navigation][:direction] = nil
 end
 
 def get_nav
   respond_to do |format|
     nav = session[:navigation]
     verse = Verse.find(nav[:verse])
     users = verse.current_users
     history = current_user.recent_history unless not signed_in?
     response = { verse: verse.id, link: verse.link, path: verse.path, mode: nav[:mode], direction: nav[:direction], nt: verse.nt? , users: users, history: history}
     format.json { render json: response}
   end
 end
 
 def current_users
   @verse = Verse.find(session[:navigation][:verse] )
   record = VerseHistoryRecord.find(session[:navigation][:record_id])
   if record.verse_id == @verse.id
     record.updated_at = -> { Time.now }.call
     record.save
   elsif record.verse_id != @verse.id
     new_record = VerseHistoryRecord.create(user_id: current_user.id, verse_id: @verse.id)
     session[:navigation][:record_id] = new_record.id
   elsif record == nil
     new_record = VerseHistoryRecord.create(user_id: current_user.id, verse_id: @verse.id)
     session[:navigation][:record_id] = new_record.id
   end
   respond_to do |format|
     format.json { render json: @verse.current_users }
   end
 end
 
 def set_nav
   # should add to this on an as-needed basis
   # because the JS shouldn't have too much access to this
   
   # if params[:mode] != nil
   #   navigation[:mode] = params[:mode]
   # end
   response = {}
   if params[:direction] != nil
     session[:navigation][:direction] = params[:direction]
     response[:direction] = params[:direction]
   end
   respond_to do |format|
     format.json{ render json: response }
    end
 end
   
end