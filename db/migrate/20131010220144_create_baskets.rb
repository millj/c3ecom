class CreateBaskets < ActiveRecord::Migration
  def change
    create_table :baskets do |t|
      t.string :basket_num
      t.string :order_num
      t.string :location_num

      t.timestamps
    end
  end
end
