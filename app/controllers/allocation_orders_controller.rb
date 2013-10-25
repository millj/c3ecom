class AllocationOrdersController < ApplicationController

  def show
    @allocation_orders = AllocationOrder.find(params[:id])
  end

  def index
    @allocation_orders = AllocationOrder.search(params[:search], params[:page])
  end

  private

  def allocation_orders_params
    params.require(:allocation_orders).permit(:order_num, :order_date, :order_priority, :order_complete, :order_processed)
  end


end
