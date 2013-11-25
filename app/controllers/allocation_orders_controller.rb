class AllocationOrdersController < ApplicationController

  def show
    @allocation_orders = AllocationOrder.find(params[:id])
  end

  def index
    @allocation_orders = AllocationOrder.search(params[:search], params[:page])
  end


  def selection
    @allocation_orders = AllocationOrder.order_selection
    #@allocation_orders=AllocationOrder.find_by_sql('SELECT a.order_num, c.basket_num FROM c3ecom.allocation_orders a,  c3ecom.baskets c WHERE NOT EXISTS (SELECT * FROM c3ecom.allocation_order_lines b     WHERE b.order_num = a.order_num   AND   b.qty_required <> b.qty_scanned)   AND   c.order_num = a.order_num')

  end

  def display
    @allocation_order = AllocationOrder.find_by_order_num(params[:id])
    @basket_num = Basket.find_by_order_num(@allocation_order.order_num).basket_num

    @special_message = Order.find_by_order_no(@allocation_order.order_num).special_request_text
    print @special_message

  end

  private

  def allocation_orders_params
    params.require(:allocation_orders).permit(:order_num, :order_date, :order_priority, :order_complete, :order_processed)
  end


end
