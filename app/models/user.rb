class User < ActiveRecord::Base
  
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  validates_uniqueness_of :name, :email
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
  # def favorites
  #   return FavoriteVerse.where("user_id=?",id).all
  # end
  
  def headline
    return VerseText.find(headline_id)
  end
  
end
