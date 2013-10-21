class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string :item_code
      t.string :description
      t.string :vendor_code
      t.string :upc

      t.timestamps
    end
  end
end
