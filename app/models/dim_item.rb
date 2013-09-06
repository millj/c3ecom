class DimItem < ActiveRecord::Base

  self.table_name = 'c3dss.dim_item'
  self.primary_key = 'item_code'

  default_scope -> { order('item_code ASC')}

  self.per_page = 25




end
