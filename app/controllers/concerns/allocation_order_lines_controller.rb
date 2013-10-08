class AllocationOrderLinesController < ApplicationController

  def allocate_item
    sql_query = 'truncate table c3dss.temp_josh'
    ActiveRecord::Base.connection.execute(sql_query)
    flash[:success] = 'UPC' + params[:upc]
    redirect_to truncate_path
  end


end
