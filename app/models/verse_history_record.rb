class VerseHistoryRecord < ActiveRecord::Base
  belongs_to :user
  belongs_to :verse
  scope :current, where("updated_at >= ?", -> {POLLING_INTERVAL.seconds.ago.time}.call)
  
  def html_format
    # {"created_at":"2012-07-08T10:49:46Z","id":998,"updated_at":"2012-07-08T10:52:04Z","user_id":3,"verse_id":18758}
    chapter = verse.chapter
    book = chapter.book
    entry = "<div align='center' class='history_entry' title ='" + created_at.getlocal.to_s.html_safe + "' onclick='	window.location.href=\"" +  verse.path + "\"'>"
    entry += book.name.to_s + " "
    entry += chapter.name.to_s + ":"
    entry += verse.name.to_s
    entry += "</div>"
    return entry.html_safe
  end
  
end