class NavigationController < ApplicationController  
  after_filter :store_navigation_in_session
 
 #assumes the rest of the code has been updating the instance variables
 #and that the session data might be old
 #so it updates the session with the instance variables
 #desirable??
 def store_navigation_in_session
   session[:navigation] = {:book => nil, :chapter => nil, :verse => nil}
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
 
 def get_nav
   respond_to do |format|
     verse = Verse.find(session[:navigation][:verse])
     puts "GOT FROM SESSION"
     puts session[:navigation]
     response = { verse: verse.id, link: verse.link, path: verse.path }
     format.json { render json: response}
   end
 end
 
 def set_nav
   if params[:mode] != nil
     navigation[:mode] = params[:mode]
   end
 end
  
end