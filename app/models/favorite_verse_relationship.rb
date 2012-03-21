class FavoriteVerseRelationship < FavoriteRelationship
    belongs_to :favorite, :class_name => "Verse", :foreign_key => "favorite_id"
end