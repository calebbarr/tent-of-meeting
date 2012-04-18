class StrongsController < ApplicationController
  def index
  end
  
  def greek
    @greek_words = NTGreekWord.where("strong_id>=?",1).order("strong_id").page(params[:page])
    puts "FIRST!!!"
    puts @greek_words.first.form
  end
  
  def hebrew
    @hebrew_words = OTHebrewWord.where("strong_id>=?",1).order("strong_id").page(params[:page])
  end

end
