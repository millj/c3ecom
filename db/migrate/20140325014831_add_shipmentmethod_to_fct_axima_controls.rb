class AddShipmentmethodToFctAximaControls < ActiveRecord::Migration
  def change
    add_column :fct_axima_controls, :shipment_method, :string
  end
end
