class CreatePickPaths < ActiveRecord::Migration
  def change
    create_table :pick_paths do |t|
      t.string :bin_name
      t.integer :pick_order

      t.timestamps
    end
  end
end
