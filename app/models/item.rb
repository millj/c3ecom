class Item < ActiveRecord::Base

  self.table_name = 'c3dss.dim_item'

  self.per_page = 50

  def self.search(search, page)
    paginate :per_page => 25, :page => page,
             :conditions => ['item_code like ? or upc like ?', "%#{search}%", "%#{search}%"],
             :order => 'item_code'
  end

end