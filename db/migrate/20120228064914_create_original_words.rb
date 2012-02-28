class CreateOriginalWords < ActiveRecord::Migration
  def change
    create_table :original_words do |t|
      t.integer :strong_id
      t.string :form
      t.string :type

      t.timestamps
    end
  end
end
