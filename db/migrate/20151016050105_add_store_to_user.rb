class AddStoreToUser < ActiveRecord::Migration
  def change
    add_column :users, :store, :boolean
  end
end
