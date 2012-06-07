class AddHeadlineIdToUsers < ActiveRecord::Migration
  def change
    add_column :users, :headline_id, :integer
  end
end
