class AddShipmentnumberToFctAximaControls < ActiveRecord::Migration
  def change
    add_column :fct_axima_controls, :shipment_number, :string
  end
end
