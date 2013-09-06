class DimItem < ActiveRecord::Base

  default_scope -> { order('item_code ASC')}

  self.per_page = 25

  set_table_name "c3dss.dim_item"
  set_primary_key :item_code

  def self.search(search, page)
    paginate :per_page => 25, :page => page,
             :conditions => ['item_code like ? or upc like ?', "%#{search}%", "%#{search}%"],
             :order => 'item_code'
  end
end
