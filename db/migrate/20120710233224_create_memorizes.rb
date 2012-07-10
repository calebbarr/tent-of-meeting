class CreateMemorizes < ActiveRecord::Migration
  def change
    create_table :memorizes do |t|
      t.integer :verse_id
      t.string :status
      t.text :tokens
      t.text :values

      t.timestamps
    end
  end
end
