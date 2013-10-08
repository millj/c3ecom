class AllocationOrderLinesController < ApplicationController

 def allocate_item
   basket_number = params[:upc]
   sql_query = 'truncate table c3dss.' + basket_number

   render :allocate
 end

  def index

  end

  def show

  end

end
