class FctWmsCartonAsnControl < ActiveRecord::Base

  self.table_name = 'c3dss.fct_wms_carton_asn_control'
  self.primary_key = 'sscc'


  def self.search(search, page)
    paginate :per_page => 25, :page => page,
             :conditions => ['sscc like ?', "%#{search}%"],
             :order => 'sscc'
  end
end

