class AllocationOrder < ActiveRecord::Base

  self.table_name = 'c3ecom.allocation_orders'

  validates :order_num, presence: true
  validates :order_date, presence: true



  self.per_page = 25

  def self.search(search, page)
    paginate :per_page => 25, :page => page,
             :conditions => ['order_num like ?', "%#{search}%"],
             :order => 'order_num'
  end

end
