class AddLeadtimeToFctVendorAximaLeadtime < ActiveRecord::Migration
  def change
    add_column :fct_vendor_axima_leadtimes, :order_processing_leadtime, :integer
    add_column :fct_vendor_axima_leadtimes, :shipping_leadtime_exp, :integer
    add_column :fct_vendor_axima_leadtimes, :shipping_leadtime_exp_haz, :integer
    add_column :fct_vendor_axima_leadtimes, :shipping_leadtime_reg, :integer
    add_column :fct_vendor_axima_leadtimes, :shipping_leadtime_reg_haz, :integer
    add_column :fct_vendor_axima_leadtimes, :whs_processing_time, :integer
  end
end
