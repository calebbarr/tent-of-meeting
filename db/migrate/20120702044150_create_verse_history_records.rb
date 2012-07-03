class CreateVerseHistoryRecords < ActiveRecord::Migration
  def change
    create_table :verse_history_records do |t|
      t.integer :user_id
      t.integer :verse_id

      t.timestamps
    end
  end
end
