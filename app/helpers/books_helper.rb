module BooksHelper
  def book_audio_url(book_id,book_name)
    url = CHAPTER_AUDIO_URL_STEM
    # adds  e.g. 01_Gen/01Gen001.mp3
    if book_id.length < 2 then
      book_id = "0"+book_id
    end
    book_abbreviation = book_name[0] =~ /[0-9]/ ? book_name[0,4].capitalize.gsub(/\s+/,"") : book_name[0,3].capitalize.gsub(/\s+/,"")
    book_abbreviation_underscored = book_id + "_" + book_abbreviation
    url += book_abbreviation_underscored + "/"
    url += book_id + book_abbreviation
    url+=".m3u"
    return url
  end
end
