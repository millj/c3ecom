class CreateFctStorePickScans < ActiveRecord::Migration
  def change
    create_table :fct_store_pick_scans do |t|
      t.string :store_code
      t.datetime :start_time
      t.datetime :end_time
      t.string :wpi_code
      t.string :wsn_code
      t.string :picked_by
      t.string :checked_by
      t.string :scanned_by

      t.timestamps
    end
  end
end
