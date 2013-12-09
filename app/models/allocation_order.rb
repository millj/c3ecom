class AllocationOrder < ActiveRecord::Base

  self.table_name = 'c3ecom.allocation_orders'

  #has_many :baskets
  #belongs_to :order

  validates :order_num, presence: true
  validates :order_date, presence: true

  #accepts_nested_attributes_for :order



  self.per_page = 25

  def self.search(search, page)
    paginate :per_page => 25, :page => page,
             :conditions => ['order_num like ?', "%#{search}%"],
             :order => 'order_num'
  end

  def self.order_selection
    sql_query = 'SELECT a.order_num,
                        c.basket_num,
                        a.order_date,
                        a.order_priority,
                        a.order_processed
                   FROM c3ecom.allocation_orders a,
                        c3ecom.baskets c
                   WHERE NOT EXISTS (SELECT *
                                       FROM c3ecom.allocation_order_lines b
                                       WHERE b.order_num = a.order_num
                                         AND   b.qty_required <> b.qty_scanned)
                     AND c.order_num = a.order_num
                     AND a.order_complete = 0
                     and a.order_processed = false
                   order by a.order_priority, a.order_date'

    connection.select_all(sql_query)
  end

end
