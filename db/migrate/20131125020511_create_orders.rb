class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.string :order_id,    limit: 55
      t.string :order_no,    limit: 15
      t.string :customer_id, limit: 45
      t.string :first_name,  limit: 45
      t.string :last_name,   limit: 45
      t.string :email,       limit: 60
      t.datetime :when_created
      t.integer  :status_id
      t.datetime :shipping_date
      t.string   :shipping_ref, limit: 100
      t.string   :rpro_customer_id, limit: 45
      t.string   :is_special_request, limit:5
      t.text     :special_request_text
      t.string   :is_gift_wrapped
      t.string   :billing_address_id, limit:45
      t.string   :shipping_address_id, limit:45
      t.integer  :shipping_method_id
      t.string   :phone, limit:45
      t.string   :evening_phone, limit:45
      t.string   :bl_card_id, limit:100
      t.text     :gift_text

      t.timestamps
    end
  end
end
