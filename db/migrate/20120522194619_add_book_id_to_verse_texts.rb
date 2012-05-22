class AddBookIdToVerseTexts < ActiveRecord::Migration
  def change
    add_column :verse_texts, :book_id, :integer
  end
end
