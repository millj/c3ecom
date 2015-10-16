class CreateFctWmsCartonAsnControls < ActiveRecord::Migration
  def change
    create_table :fct_wms_carton_asn_controls do |t|
      t.integer :exported
      t.string :store_code
      t.string :sscc
      t.string :to_number
      t.datetime :date_shipped
      t.datetime :date_exported

      t.timestamps
    end
  end
end
