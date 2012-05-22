class TentOfMeetingCell < Cell::Rails
  include Devise::Controllers::Helpers
  before_filter :get_instance_variables
  
  def get_instance_variables
    if session[:navigation] != nil then
      if session[:navigation][:verse] != nil then
        @verse = Verse.find(session[:navigation][:verse])
      else
        # @TODO
        @verse = Verse.find(1)
        #this should really be the last visited verse (navigation history to be stored in User), *maybe* 
        #default to 1 if no one's logged in (if we don't want to build up a session-based navigation history)
      end
      @chapter = @verse.chapter
      @book = @chapter.book
    end
  end
  
end  