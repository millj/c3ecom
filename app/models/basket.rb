class Basket < ActiveRecord::Base

  self.table_name = 'c3ecom.baskets'

  validates :basket_num,  numericality: { only_integer: true }


  self.per_page = 25

  has_and_belongs_to_many :allocation_order, :foreign_key => :order_num



  def self.search(search, page)
    paginate :per_page => 25, :page => page,
             :conditions => ['basket_num like ? or order_num like ?', "#{search}", "#{search}"],
             :order => 'basket_num'
  end

end
