class AddDirectToUsers < ActiveRecord::Migration
  def change
    add_column :users, :direct, :boolean
  end
end
