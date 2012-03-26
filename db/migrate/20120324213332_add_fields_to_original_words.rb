class AddFieldsToOriginalWords < ActiveRecord::Migration
  def change
    add_column :original_words, :transliteration, :string
    add_column :original_words, :phonetic_spelling, :string
    add_column :original_words, :short_definition, :string
    add_column :original_words, :medium_definition, :text
    add_column :original_words, :long_definition, :text
  end
end
