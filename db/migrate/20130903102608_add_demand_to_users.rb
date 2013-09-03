class AddDemandToUsers < ActiveRecord::Migration
  def change
    add_column :users, :demand, :boolean
  end
end
