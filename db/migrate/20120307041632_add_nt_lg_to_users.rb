class AddNtLgToUsers < ActiveRecord::Migration
  def change
    add_column :users, :nt_lg, :string
  end
end
