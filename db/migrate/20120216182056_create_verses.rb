class CreateVerses < ActiveRecord::Migration
  def change
    create_table :verses do |t|
      t.integer :chapter_id
      t.integer :name

      t.timestamps
    end
  end
end
