module VersesHelper
  def audio_url(verse_name,chapter_name,book_name,book_id_string)
    book_stem = VERSE_AUDIO_BOOK_ABBREV.has_key?(book_name) ? VERSE_AUDIO_BOOK_ABBREV[book_name] : book_name.gsub(/ /,"")[0,3].upcase
    if book_id_string.length < 2 then
      book_id_string = "0"+book_id_string
    end
    if chapter_name.length < 2 then
      chapter_name = "0"+chapter_name
    end
    if verse_name.length < 2 then
      verse_name = "0"+verse_name
    end
    
    if book_stem == "PSA" then
      if chapter_name.length < 3 then
        chapter_name = "0"+chapter_name
      end
      if verse_name.length < 3 then
        verse_name = "0"+verse_name
      end
    end
    
    book_prefix = book_id_string + "_" + book_stem
    return VERSE_AUDIO_URL_STEM + "/" + book_prefix + "/" + book_prefix + "_" + chapter_name + "_" + verse_name +".MP3"
  end
  
  def highlight( result_string, query_string )
    highlighted_html = ""
    result_string.split(/\s+/).each do |token|
      #@TODO
      # needs to be a better helper method
      #testing against more possibilities more thoroughly
      # and accounting for non-english
      if (token == query_string ) or (token == query_string+"'s") or (token == query_string+",") or (token == query_string+"'d") or (token == query_string+"s") or (token == query_string+".") or (token == query_string+"\"")
        highlighted_html += "<b>"+token+" </b>"
      else
        highlighted_html += token+" "
      end
    end
    return highlighted_html.html_safe
  end
      
end
