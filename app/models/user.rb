class User < ActiveRecord::Base
  
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  validates_uniqueness_of :name, :email
  validates_length_of :name, :within => 3..10, :too_long => "pick a shorter name", :too_short => "pick a longer name"
  mount_uploader :image, ImageUploader

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :ot_lg, :nt_lg, :name, :image, :headline_id
  has_many :favorite_verse_relationships, :foreign_key => "user_id", :class_name => "FavoriteVerseRelationship" 
  has_many :favorite_verses, :through => :favorite_verse_relationships, :source => :favorite, :class_name => "Verse"
  has_many :notes  
  
  # def self.favorites
  #   return FavoriteVerse.where("user_id=?",user_id).all
  # end
  # 
  def favorites
    return FavoriteVerse.where("user_id=?",id).all
  end
  
  def favorite?(verse_id)
    return FavoriteVerseRelationship.where("user_id=?",id).where("favorite_id=?",verse_id).length > 0
  end
  
  def headline
    return VerseText.find(headline_id)
  end
  
  def headline_text
    return VerseText.find(headline_id).content
  end
  
  def history
    return VerseHistoryRecord.where("user_id=?",id).order(:created_at).reverse_order()
  end
  
  def recent_history
    entries = []
    index = 0
    VerseHistoryRecord.where("user_id=?",id).order(:created_at).reverse_order().limit(11).each do |entry|
      if index > 0
        entries << entry.html_format
      end
      index +=1
    end
    return entries
  end
  
  def last_seen_at
    return recent_history[0]
    #is this correct?
  end
  
  def current_verse
    return -> {history.current}.call#.all[0] ?
  end
  
end
