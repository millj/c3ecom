class RenameColumn3 < ActiveRecord::Migration
  def change
  rename_column :fct_vendor_axima_leadtimes, :lead_time_days, :vendor_turnaround
  end
end
