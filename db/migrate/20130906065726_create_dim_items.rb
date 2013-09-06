class CreateDimItems < ActiveRecord::Migration
  def change
    create_table :dim_items do |t|
      t.string :item_code

      t.timestamps
    end
  end
end
