class MbOrderStatusesController < ApplicationController


  def show
    @mb_order_statuses = MbOrderStatus.find(params[:order_number])
  end


  def index
    @mb_order_statuses = MbOrderStatus.search(params[:search], params[:page])
  end
  

  end