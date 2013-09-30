class PickPath < ActiveRecord::Base

  self.table_name = 'pick_paths'

  default_scope -> { order('pick_order ASC') }

  validates :bin_name, presence: true, length: {maximum: 15}
  validates :pick_order, presence:true, :inclusion => { :in => 1..9999, :message => "Pick order between 1 to 9999" }

  self.per_page = 25



  def self.search(search, page)
    paginate :per_page => 25, :page => page,
             :conditions => ['bin_name like ?', "%#{search}%"],
             :order => 'bin_name'
  end

end
