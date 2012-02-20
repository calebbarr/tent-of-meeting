class CreateMultipleChoiceQuestions < ActiveRecord::Migration
  def change
    create_table :multiple_choice_questions do |t|
      t.integer :verse_id
      t.text :content
      t.text :a
      t.text :b
      t.text :c
      t.text :d
      t.string :correct

      t.timestamps
    end
  end
end
