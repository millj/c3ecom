class FctCountableStock < ActiveRecord::Base

  self.table_name = 'c3dss.fct_countable_stock'

  def self.search(search, page)
    paginate :per_page => 25, :page => page,
             :conditions => ['location like ? or bin_code like ?', "%#{search}%", "%#{search}%"],
             :order => 'location desc, bin_code desc'
  end

end
