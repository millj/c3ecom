class CreateFctVendorAximaLeadtimes < ActiveRecord::Migration
  def change
    create_table :fct_vendor_axima_leadtimes do |t|
      t.string :vendor_code
      t.integer :lead_time_days

      t.timestamps
    end
  end
end
