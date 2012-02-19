class NavigationController < ApplicationController
  after_filter :store_navigation_in_session
  
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
  
end