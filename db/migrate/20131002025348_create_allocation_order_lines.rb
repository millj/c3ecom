class CreateAllocationOrderLines < ActiveRecord::Migration
  def change
    create_table :allocation_order_lines do |t|
      t.string :order_num
      t.string :item_code
      t.string :upc
      t.integer :qty_required
      t.integer :qty_scanned

      t.timestamps
    end
  end
end
