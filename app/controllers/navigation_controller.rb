class NavigationController < ApplicationController
  before_filter :initialize_navigation
  after_filter :store_navigation_in_session
  
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
 end
 
 def get_navigation_from_session
   return session[:navigation]
 end
 
 def set_mode(mode)
   session[:navigation][:mode] = mode
   puts session[:navigation]
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
     response = { verse: verse.id, link: verse.link, path: verse.path, mode: nav[:mode], direction: nav[:direction], nt: verse.nt? }
     format.json { render json: response}
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