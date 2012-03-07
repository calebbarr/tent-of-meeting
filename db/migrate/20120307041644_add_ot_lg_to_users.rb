class AddOtLgToUsers < ActiveRecord::Migration
  def change
    add_column :users, :ot_lg, :string
  end
end
