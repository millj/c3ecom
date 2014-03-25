class RemoveShipmentmethodFromFctAximaControls < ActiveRecord::Migration
  def change
    remove_column :fct_axima_controls, :shipment_method, :string
  end
end
