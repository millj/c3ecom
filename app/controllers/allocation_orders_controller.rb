require 'net/http'
require 'uri'

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


  def edit
    @allocation_order = AllocationOrder.find_by_order_num(params[:id])

    unless @allocation_order.nil?
      @allocation_order.order_processed = 1
      @allocation_order.save!
      @order_number = @allocation_order.order_num

      pack_history = FctPackHistory.where(:user_name => current_user.name, :order_num => @order_number).first_or_create
      pack_history.processed_at = DateTime.current
      pack_history.save

      @order = Order.find_by_order_no(@order_number)
      @basket_num = Basket.find_by_order_num(@order_number).basket_num
      sql_query1 = 'select
                        case when site_id = \'1\' then \'Mecca\' else \'Kit\' end as order_source
                     from c3ecom.orders a, c3ecom.Customers b
                     where b.direct_customer_id = a.customer_id
                       and a.order_no = \'' + @order_number + '\''
      @order_source = ActiveRecord::Base.connection.select_value(sql_query1)

      #samples
      sql_query1 =  'SELECT s.product_name
                       FROM c3ecom.OrderSamples s,
                            c3ecom.orders o
                       WHERE s.order_id = o.order_id
                         AND order_no = \'' + @order_number + '\''
      @order_samples = ActiveRecord::Base.connection.select_all(sql_query1)

      #order items
      @order_items = AllocationOrderLine.where(:order_num => @order_number)

      # address
      sql_query2 = 'SELECT
                      a.company_name,
                      a.first_name,
                      a.last_name,
                      a.address,
                      a.suburb,
                      a.state,
                      a.postcode,
                      a.country
                FROM c3ecom.OrderAddress a,
                     c3ecom.orders o
                WHERE a.address_id = o.shipping_address_id
                AND   order_no = \'' + @order_number + '\''
      @address= ActiveRecord::Base.connection.select_one(sql_query2)

    end

    def print_message
      @allocation_order = AllocationOrder.find(params[:id])
      uri = URI.parse('http://dss.ccubed.local:8084/pentaho/ViewAction')
      params = { :solution => 'IT', :action =>'Print_gift_messages2.xaction', :order => @allocation_order.order_num, :path => '', :userid => 'report', :password => 'report' }
      uri.query = URI.encode_www_form(params)
      res = Net::HTTP.get_response(uri)

      flash[:success] = "Message printed"

      redirect_to edit_allocation_order_path(@allocation_order.order_num)
    end

  end

    def update
      @allocation_order = AllocationOrder.find(params[:id])
      @order_num = @allocation_order.order_num
      @order = Order.find_by_order_no(@order_num)

      respond_to do |format|
        if @allocation_order.update_attributes(:order_complete => 1)
            # allocation_orders_params                 print res.code
          pack_history = FctPackHistory.find_by_order_num(@order_num)
          pack_history.completed_at = DateTime.current
          pack_history.save

          uri = URI.parse('http://dss.ccubed.local:8084/pentaho/ViewAction')
          params = { :solution => 'IT', :action =>'despatcher_sequence_v6.xaction', :order => @allocation_order.order_num, :path => '', :userid => 'report', :password => 'report' }
          uri.query = URI.encode_www_form(params)
          res = Net::HTTP.get_response(uri)

          flash[:success] = "Order ##{@order_num} was successfully completed"
          format.html { redirect_to order_selection_path }
          format.xml { head :ok }
        else
          format.html { render :action => "edit" }
        end

      end
    end


  private

  def allocation_orders_params
    params.require(:allocation_order).permit(:order_num, :order_date, :order_priority, :order_complete, :order_processed)
  end

end
