class FctStorePickScan < ActiveRecord::Base

  self.table_name = 'c3dss.fct_store_pick_scans'

  validates :store_code, presence: true, length: {maximum: 15}
  validates :pick_date, presence: true
  validates :wsn_code, length: {maximum: 15}
  validates :wpi_code, length: {maximum: 15}
  validates :picked_by, length: {maximum: 15}
  validates :wpi_code, length: {maximum: 15}
  validates :scanned_by, length: {maximum: 15}
  validates :picked_by, length: {maximum: 15}
  validates :checked_by, length: {maximum: 15}

  self.per_page = 25

  def self.search(search, page)
    paginate :per_page => 25, :page => page,
             :conditions => ['store_code like ? or wpi_code like ? or wsn_code like ? or picked_by like ? or scanned_by like ? or checked_by like ?', "%#{search}%", "%#{search}%", "%#{search}%", "%#{search}%", "%#{search}%", "%#{search}%"],
             :order => 'store_code, wpi_code'
  end

end
