class MbOrderStatus < ActiveRecord::Base

  self.table_name = 'mbecom.mb_order_status'

  def self.search(search, page)
    paginate :per_page => 25, :page => page,
             :conditions => ['order_number like ?', "%#{search}%"],
             :order => 'order_number desc'
  end


end
