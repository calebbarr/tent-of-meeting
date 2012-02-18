class NavigationController < ApplicationController
  after_filter :store_navigation_in_session
  
  def store_navigation_in_session
    session[:navigation] = {:book => nil, :chapter => nil, :verse => nil}
    if @book != nil then
      session[:navigation][:book] = @book.id
    end
    if @chapter != nil then
      session[:navigation][:chapter] = @chapter.id
    end
    if @verse != nil then
      session[:navigation][:verse] = @verse.id
    end
  end
  
  def get_navigation_from_session
    return session[:navigation]
  end
  
end