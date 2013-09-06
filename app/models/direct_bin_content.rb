class DirectBinContent < ActiveRecord::Base

  validates :bin_name, presence: true, length: {maximum: 15}
  validates :item_code, presence: true, length: {maximum: 15}

  default_scope -> { order('bin_name ASC')}

  self.per_page = 25



  def self.search(search, page)
    paginate :per_page => 25, :page => page,
             :conditions => ['item_code like ? or bin_name like ?', "%#{search}%", "%#{search}%"],
             :order => 'bin_name, item_code'
  end



end
