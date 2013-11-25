class AllocationOrder < ActiveRecord::Base

  self.table_name = 'c3ecom.allocation_orders'

  #has_many :baskets

  validates :order_num, presence: true
  validates :order_date, presence: true



  self.per_page = 25

  def self.search(search, page)
    paginate :per_page => 25, :page => page,
             :conditions => ['order_num like ?', "%#{search}%"],
             :order => 'order_num'
  end

  def self.order_selection
    sql_query = 'SELECT a.order_num,
                       c.basket_num
                FROM c3ecom.allocation_orders a,
                     c3ecom.baskets c
                WHERE NOT EXISTS (SELECT *
                                  FROM c3ecom.allocation_order_lines b
                                  WHERE b.order_num = a.order_num
                                  AND   b.qty_required <> b.qty_scanned)
                AND   c.order_num = a.order_num'

    connection.select_all(sql_query)
  end

end
