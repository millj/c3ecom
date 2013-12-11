class CreateFctRproSos < ActiveRecord::Migration
  def change
    create_table :fct_rpro_sos do |t|
      t.string :so_sid
      t.string :so_no
      t.string :invc_sid
      t.string :ecommerce_order_no

      t.timestamps
    end
  end
end
