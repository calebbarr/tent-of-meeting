class CreateOriginalVerses < ActiveRecord::Migration
  def change
    create_table :original_verses do |t|
      t.string :content
      t.string :strong_ids
      t.string :type
      t.integer :verse_id

      t.timestamps
    end
  end
end
