class CreateRelatedVerses < ActiveRecord::Migration
  def change
    create_table :related_verses do |t|
      t.integer :relatee_id
      t.integer :related_id
      t.timestamps
    end
  end
end
