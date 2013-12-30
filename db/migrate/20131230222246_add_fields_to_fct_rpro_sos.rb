class AddFieldsToFctRproSos < ActiveRecord::Migration
  def change
    add_column :fct_rpro_sos, :freight_tracking_num, :string
    add_column :fct_rpro_sos, :customer_name, :string
  end
end
