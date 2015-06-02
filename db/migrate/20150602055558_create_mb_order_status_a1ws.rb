class CreateMbOrderStatusA1ws < ActiveRecord::Migration
  def change
    create_table :mb_order_status_a1ws do |t|
      t.string :order_id
      t.integer :order_ecom_status
      t.integer :order_rpro_status
      t.string :order_number
      t.integer :priority

      t.timestamps
    end
  end
end
