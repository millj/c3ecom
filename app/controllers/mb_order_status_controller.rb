class MbOrderStatusController < ApplicationController


  def show
    @mb_order_status = MbOrderStatus.find(params[:order_number])
  end


  def index
    @mb_order_status = MbOrderStatus.search(params[:search], params[:page])
  end
  

  end