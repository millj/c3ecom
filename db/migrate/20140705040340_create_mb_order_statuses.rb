class CreateMbOrderStatuses < ActiveRecord::Migration
  def change
    create_table :mb_order_statuses do |t|
      t.string :order_id
      t.integer :order_ecom_status
      t.integer :order_rpro_status
      t.string :web_order_id
      t.string :order_number
      t.integer :priority

      t.timestamps
    end
  end
end
