class AddChapterIdToVerseTexts < ActiveRecord::Migration
  def change
    add_column :verse_texts, :chapter_id, :integer
  end
end
