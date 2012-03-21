class CreateFavoriteRelationships < ActiveRecord::Migration
  def change
    create_table :favorite_relationships do |t|
      t.integer :user_id
      t.string :type
      t.integer :favorite_id

      t.timestamps
    end
  end
end
