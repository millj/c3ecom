class FctVendorAximaLeadtime < ActiveRecord::Base

  self.table_name = 'c3dss.fct_vendor_axima_leadtime'

  def self.search(search, page)
    paginate :per_page => 25, :page => page,
             :conditions => ['vendor_code like ? or vendor_code like ?', "%#{search}%"],
             :order => 'vendor_code desc'
  end


end
