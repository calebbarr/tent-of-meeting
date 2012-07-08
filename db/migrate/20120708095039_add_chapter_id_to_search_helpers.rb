class AddChapterIdToSearchHelpers < ActiveRecord::Migration
  def change
    add_column :search_helpers, :chapter_id, :integer
  end
end
