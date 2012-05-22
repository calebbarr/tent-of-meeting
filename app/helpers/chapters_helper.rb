module ChaptersHelper
  def chapter_audio_url(book_id,book_name,chapter_name)
    url = CHAPTER_AUDIO_URL_STEM
    # adds  e.g. 01_Gen/01Gen001.mp3
    if book_id.length < 2 then
      book_id = "0"+book_id
    end
    # book_abbreviation = CHAPTER_AUDIO_BOOK_ABBREV.has_key?(book_name) ? CHAPTER_AUDIO_BOOK_ABBREV[book_name] : book_name[0,3].capitalize
    book_abbreviation = book_name[0] =~ /[0-9]/ ? book_name[0,4].capitalize.gsub(/\s+/,"") : book_name[0,3].capitalize.gsub(/\s+/,"")
    book_abbreviation_underscored = book_id + "_" + book_abbreviation
    url += book_abbreviation_underscored+"/"
    chapter_name = chapter_name.length < 3 ? "0" + chapter_name : chapter_name
    chapter_name = chapter_name.length < 3 ? "0" + chapter_name : chapter_name
    url += book_id+book_abbreviation+chapter_name
    url+=".mp3"
    return url
  end
end
