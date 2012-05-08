class AddNormalizedFormToOriginalWords < ActiveRecord::Migration
  def change
    add_column :original_words, :normalized_form, :string
  end
end
