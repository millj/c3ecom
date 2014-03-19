class FctVendorAximaLeadtime < ActiveRecord::Base

  self.table_name = 'c3dss.fct_vendor_axima_leadtime'
  self.primary_key = 'vendor_code'
  validates :vendor_code, presence: true, length: {maximum: 15}
  validates :lead_time_days, presence:true, :inclusion => { :in => 1..99, :message => "Between 1 to 99" }

  def self.search(search, page)
    paginate :per_page => 25, :page => page,
             :conditions => ['vendor_code like ?', "%#{search}%"],
             :order => 'vendor_code'
  end


end
