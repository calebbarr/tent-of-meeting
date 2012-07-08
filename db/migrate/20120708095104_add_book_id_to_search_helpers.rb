class AddBookIdToSearchHelpers < ActiveRecord::Migration
  def change
    add_column :search_helpers, :book_id, :integer
  end
end
