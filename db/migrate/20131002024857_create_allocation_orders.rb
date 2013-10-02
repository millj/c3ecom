class CreateAllocationOrders < ActiveRecord::Migration
  def change
    create_table :allocation_orders do |t|
      t.string :order_num
      t.datetime :order_date
      t.integer :order_priority
      t.boolean :order_complete
      t.boolean :order_processed

      t.timestamps
    end
  end
end
