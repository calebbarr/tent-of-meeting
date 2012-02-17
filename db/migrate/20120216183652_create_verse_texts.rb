class CreateVerseTexts < ActiveRecord::Migration
  def change
    create_table :verse_texts do |t|
      t.string :language
      t.text :content
      t.integer :verse_id

      t.timestamps
    end
  end
end
