class CreateDirectBinContents < ActiveRecord::Migration
  def change
    create_table :direct_bin_contents do |t|
      t.string :bin_name
      t.string :item_code

      t.timestamps
    end
  end
end
