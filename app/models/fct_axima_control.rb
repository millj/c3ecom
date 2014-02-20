class FctAximaControl < ActiveRecord::Base

  self.table_name = 'c3dss.fct_axima_control'

  def self.search(search, page)
    paginate :per_page => 25, :page => page,
             :conditions => ['purchase_order_no like ? or vendor_code like ?', "%#{search}%", "%#{search}%"],
             :order => 'purchase_order_no, vendor_code'
  end


end
