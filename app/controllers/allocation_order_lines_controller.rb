class AllocationOrderLinesController < ApplicationController

 def allocate_item
   @basket_number = params[:upc]

   render :allocate

 end

  def index

  end

  def show

  end

end
