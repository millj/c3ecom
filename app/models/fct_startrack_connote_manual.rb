class FctStartrackConnoteManual < ActiveRecord::Base
  self.table_name = 'c3ecom.fct_startrack_connote_manual'

  self.per_page = 25

  def self.search(search, page)
    paginate :per_page => 25, :page => page,
             :conditions => ['order_no like ?', "%#{search}%"],
             :order => 'order_no'
  end
end
