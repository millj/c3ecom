class AddDirect2ToUsers < ActiveRecord::Migration
  def change
    add_column :users, :direct2, :boolean
  end
end
