class CreateOriginalInflectedWords < ActiveRecord::Migration
  def change
    create_table :original_inflected_words do |t|
      t.integer :strong_id
      t.string :form
      t.string :type
      t.string :transliteration
      t.string :binyan
      t.string :tense
      t.string :pos
      t.string :case
      t.string :number
      t.string :gender
      t.string :person
      t.string :mood
      t.string :voice

      t.timestamps
    end
  end
end
