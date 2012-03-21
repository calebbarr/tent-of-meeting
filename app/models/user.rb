class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :ot_lg, :nt_lg
  has_many :favorite_verse_relationships, :foreign_key => "user_id", :class_name => "FavoriteVerseRelationship" 
  has_many :favorite_verses, :through => :favorite_verse_relationships, :source => :favorite, :class_name => "Verse"
  
  # def self.favorites
  #   return FavoriteVerse.where("user_id=?",user_id).all
  # end
  # 
  # def favorites
  #   return FavoriteVerse.where("user_id=?",id).all
  # end
  
end
