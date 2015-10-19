class FctWmsCartonAsnControl < ActiveRecord::Base

  self.table_name = 'c3dss.fct_wms_carton_asn_control'
  self.primary_key = 'sscc'

  default_scope { where ("exported = 0")}

  def self.search(search, page)
    paginate :per_page => 25, :page => page,
             :conditions => ['sscc like ? or to_number like ?', "%#{search}%", "%#{search}%"],
             :order => 'sscc'
  end
end

