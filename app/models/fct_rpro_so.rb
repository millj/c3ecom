class FctRproSo < ActiveRecord::Base

  self.table_name = 'c3dss.fct_rpro_so'

  def self.search(search, page)
    paginate :per_page => 50, :page => page,
             :conditions => ['ecommerce_order_no like ? or receipt_number like ?', "#{search}", "#{search}"],
             :order => 'ecommerce_order_no'
  end

end
