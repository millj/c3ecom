class AddCustomerServiceToUsers < ActiveRecord::Migration
  def change
    add_column :users, :customer_service, :boolean
  end
end
