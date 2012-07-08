class CreateSearchHelpers < ActiveRecord::Migration
  def change
    create_table :search_helpers do |t|
      t.integer :verse_id
      t.text :content

      t.timestamps
    end
  end
end
