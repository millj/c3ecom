class AllocationOrder < ActiveRecord::Base

  self.table_name = 'allocation_orders'

  validates :order_num, presence: true
  validates :order_date, presence: true



end
