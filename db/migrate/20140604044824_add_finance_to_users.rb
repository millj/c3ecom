class AddFinanceToUsers < ActiveRecord::Migration
  def change
    add_column :users, :finance, :boolean
  end
end
