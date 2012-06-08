class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :clear_q_id, :get_instance_variables
  #need to remember to clear that out, shouldn't be done in the session
  
  # after_filter :populate_header_with_nav  
  # def populate_header_with_nav
  #   
  # end
  
  
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
  
  def clear_q_id
    session[:q_id] = nil
  end
  
  #PARSING STRINGS , FIGURE OUT WHERE TO PUT THIS LATER
  
  def is_englishish?(query)
    return (!is_hebrew?(query) and !is_number?(query) and !is_greek?(query))
  end
  
  def is_hebrew?(query)
    (0...query.length).each do |index|
      return true if HEBREW_CONSONANTS.include?(query[index])
    end
    return false
  end
  
  def is_greek?(query)
    (0...query.length).each do |index|
      return true if GREEK_LETTERS.include?(query[index])
    end
    return false
  end
  
  def is_number?(query)
    return true if Integer(query) rescue false
  end
          
end
