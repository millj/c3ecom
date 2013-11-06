class AddPickDateToFctStorePickScans < ActiveRecord::Migration
  def change
    add_column :fct_store_pick_scans, :pick_date, :date
  end
end
