class FctSpecialInstructions < ActiveRecord::Base

  self.table_name = 'mbecom.fct_special_instructions'

  def self.search(search, page)

    paginate :per_page => 25, :page => page,
             :conditions => ['order_number like ? or sscc like ?', "%#{search}%", "%#{search}%"],
             :order => 'order_number desc'
  end

end
