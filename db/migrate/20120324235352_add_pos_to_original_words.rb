class AddPosToOriginalWords < ActiveRecord::Migration
  def change
    add_column :original_words, :pos, :string
  end
end
