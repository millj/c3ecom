class AllocationOrdersController < ApplicationController

  def show
    @allocation_orders = AllocationOrder.find(params[:id])
  end

  def index
    @allocation_orders = AllocationOrder.search(params[:search], params[:page])
  end


  def selection
    @allocation_orders = AllocationOrder.order_selection

    @allocation_orders.each do |order|
      if order['order_processed'] == 1
        pack_history = FctPackHistory.where(:order_num => order['order_num']).first
          order['processed_by']  = pack_history.user_name  if  pack_history && pack_history.user_name != current_user.name
      end
    end

  end

  def complete
    redirect_to allocation_orders_url
  end

  def display
    @allocation_order = AllocationOrder.find_by_order_num(params[:id])

    unless @allocation_order.nil?
      @allocation_order.order_processed = 1
      @allocation_order.save!
      @order_number = @allocation_order.order_num

      FctPackHistory.where(:user_name => current_user.name , :order_num => @order_number).first_or_create do |pack_history|
        pack_history.processed_at = DateTime.current
      end
      @order = Order.find_by_order_no(@order_number)

      @basket_num = Basket.find_by_order_num(@order_number).basket_num

      #samples
      sql_query1 =  'SELECT s.product_name
                    FROM c3ecom.OrderSamples s,
                        c3ecom.orders o
                    WHERE s.order_id = o.order_id
                    AND order_no = \'' + @order_number + '\''
      @order_samples = ActiveRecord::Base.connection.select_all(sql_query1)

       #order items
      @allocation_order_lines = AllocationOrderLine.where(:order_num => @order_number)
        # make our own collection for Order Items
      @order_items = @allocation_order_lines.collect{|order_line| {:item_code => order_line['item_code'], :qty_required => order_line['qty_required'], :item_desc =>  Item.find_by_item_code(order_line['item_code']).description}}

    end

  end
  def edit
    @allocation_order = AllocationOrder.find_by_order_num(params[:id])

    unless @allocation_order.nil?
      @allocation_order.order_processed = 1
      @allocation_order.save!
      @order_number = @allocation_order.order_num

      FctPackHistory.where(:user_name => current_user.name , :order_num => @order_number).first_or_create do |pack_history|
        pack_history.processed_at = DateTime.current

        pack_history.save!
      end
      @order = Order.find_by_order_no(@order_number)

      @basket_num = Basket.find_by_order_num(@order_number).basket_num

      #samples
      sql_query1 =  'SELECT s.product_name
                       FROM c3ecom.OrderSamples s,
                            c3ecom.orders o
                       WHERE s.order_id = o.order_id
                         AND order_no = \'' + @order_number + '\''
      @order_samples = ActiveRecord::Base.connection.select_all(sql_query1)

      #order items
      @allocation_order_lines = AllocationOrderLine.where(:order_num => @order_number)
      # make our own collection for Order Items
      @order_items = @allocation_order_lines.collect{|order_line| {:item_code => order_line['item_code'], :qty_required => order_line['qty_required'], :item_desc =>  Item.find_by_item_code(order_line['item_code']).description}}

    end

  end

    def update
      @allocation_order = AllocationOrder.find(params[:id])
      @order = Order.find_by_order_no(@allocation_order.order_num)

      respond_to do |format|
        if @allocation_order.update_attributes(allocation_orders_params)  &&  @order.update_attributes(orders_params) #:order_complete => 1

          flash[:success] = "Order ##{@allocation_order.order_num} was successfully completed"
          format.html { redirect_to order_selection_path }
          format.xml { head :ok }
        else
          format.html { render :action => "edit" }
        end

      end
    end

  def complete

  end

  private

  def allocation_orders_params
    params.require(:allocation_order).permit(:order_num, :order_date, :order_priority, :order_complete, :order_processed)
  end

  def orders_params
    params.require(:order).permit(:gift_text, :special_request_text)
  end


end
