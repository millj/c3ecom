class AllocationOrderLine < ActiveRecord::Base
  belongs_to :allocation_order, inverse_of: allocation_order_lines

end
