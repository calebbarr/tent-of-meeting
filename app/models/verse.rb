class Verse < ActiveRecord::Base  
  belongs_to :chapter
  has_many :verse_texts
  has_many :multiple_choice_questions
  has_many :related_verses, :foreign_key => "relatee_id", class_name: "RelatedVerses"
  has_many :related, :through => :related_verses, :foreign_key => "related_id"
  has_one :original_verse
  has_many :notes
  # a util script has a problem with the kaminari reference # paginates_per  VERSE_SEARCH_RESULTS_PER_PAGE 
  
  
  
  def self.lookup(book_id,chapter_name,verse_name)
    return Book.find(book_id).verses.joins(:chapter).where("chapters.name=?",chapter_name).where(:name => verse_name).first
  end
  
  def path
    book = chapter.book
    return "/"+book.name+"/"+chapter.name.to_s+"/"+name.to_s
  end
  
  def self.random
    return Verse.find(Random.new.rand(1..NUMBER_OF_VERSES))
  end
  
  def next
    id = id.to_i
    return id+1 <= NUMBER_OF_VERSES ? Verse.find(id+1) : Verse.find(id)
  end
  
  def self.next(id)
    id = id.to_i
    return id+1 <= NUMBER_OF_VERSES ? Verse.find(id+1) : Verse.find(id)
  end
  
  def prev
    id = id.to_i
    return id-1 > 0 ? Verse.find(id-1) : Verse.find(id)
  end
  
  def self.prev(id)
    id = id.to_i
    return id-1 > 0 ? Verse.find(id-1) : Verse.find(id)
  end
  
  def self.search(query)
    #needs to handle case variation
    query = "%"+query+"%"
    # VerseText.where("content like ?", query)
    # needs to return array of verses
    # probably going to need another SQL join
  end
  
  def has_quiz?
    return multiple_choice_questions.length > 0
  end
  
  def has_note?(user_id)
    return notes.where("user_id=?", user_id).length > 0
  end
  
  def self.unfavorite(user_id,verse_id)
    FavoriteVerseRelationship.destroy(FavoriteVerseRelationship.where("favorite_id=?",verse_id).where("user_id=?",user_id).first.id)
  end
  
  def is_favorite?(user_id)
    return FavoriteVerseRelationship.where("user_id=?",user_id).where("favorite_id=?",id).all.length > 0
  end
  
  def link
    book = chapter.book
    link = ""
  	link += "<a href='/"+book.name+"'>"+book.name.to_s+"</a>"
  	link += " <a href='/"+book.name+"/"+chapter.name.to_s+"#"+name.to_s+"'>"+chapter.name.to_s+":</a>"
    link += "<a href='/"+book.name+"/"+chapter.name.to_s+"/"+name.to_s+"'>"+name.to_s+"</a>"
    return link.html_safe
  end
  
  def notes_per_user(user_id)
    return notes.where("user_id=?",user_id)
  end
  
  def ot?
    return id < FIRST_NT_VERSE
  end
  
  def nt?
    return id >= FIRST_NT_VERSE
  end
  
  def current_users
    users = []
    seen_users = Set.new
    records = VerseHistoryRecord.current.where("verse_id=?",id).order(:created_at)
    records.each do |record|
      user = record.user
      if not seen_users.include?(user.id)
        seen_users.add(user.id)
        users << {name: user.name, headline: user.headline_text, thumb: user.image_url(:thumb), icon: user.image_url(:icon) }
      end
    end
    return users
  end
  
end
