class MbOrderStatusA1wsController < ApplicationController


  def show
   @mb_order_status_a1ws = MbOrderStatusA1w.find(params[:order_number])


  end


  def index
    @mb_order_status_a1ws = MbOrderStatusA1w.search(params[:search], params[:page])

  end
  

  end