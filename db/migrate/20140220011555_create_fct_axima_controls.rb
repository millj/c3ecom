class CreateFctAximaControls < ActiveRecord::Migration
  def change
    create_table :fct_axima_controls do |t|
      t.string :purchase_order_no
      t.integer :status
      t.string :vendor_code

      t.timestamps
    end
  end
end
