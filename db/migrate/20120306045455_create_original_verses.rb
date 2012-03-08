class CreateOriginalVerses < ActiveRecord::Migration
  def change
    create_table :original_verses do |t|
      t.text :content
      t.text :strong_ids
      t.string :type
      t.integer :verse_id
      t.text :translations

      t.timestamps
    end
  end
end
