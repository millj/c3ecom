class AllocationOrderLinesController < ApplicationController

 def giftcard
  @gift_cards = AllocationOrderLine.joins('left join c3ecom.baskets on baskets.order_num = allocation_order_lines.order_num').where("item_code = 'GC' and qty_required > qty_scanned").select('allocation_order_lines.*, baskets.basket_num')
 end

 def complete_gift_card
   sql_query = 'update c3ecom.allocation_order_lines a
                   set qty_scanned = qty_required
                 where a.id = \'' + params[:id] + '\'
               '
   ActiveRecord::Base.connection.execute(sql_query)

   redirect_to giftcard_path
 end

 def allocate_item

   sql_query = 'select concat(c.basket_num, \',\', a.order_num)
                   from c3ecom.allocation_orders a,
                        c3ecom.allocation_order_lines b,
                        c3ecom.baskets c
                   where b.order_num = a.order_num
                     and (b.upc = \'' + params[:upc] + '\' or
                          b.item_code = \'' + params[:upc] + '\'
                         )

                     and b.qty_scanned < b.qty_required
                     and c.order_num = a.order_num
                    order by a.order_priority desc, a.order_date, a.order_num limit 1'
   result = ActiveRecord::Base.connection.select_value(sql_query)


   unless result.nil?

     @basket_number = result.split(",").first
     @order_number = result.split(",").second

     sql_query = 'update c3ecom.allocation_order_lines b
                     set b.qty_scanned = b.qty_scanned + 1
                     where b.order_num = \'' + @order_number + '\'
                       and (b.upc = \'' + params[:upc] + '\' or
                            b.item_code = \'' + params[:upc] + '\'
                           )
                       and b.qty_scanned < b.qty_required'
     ActiveRecord::Base.connection.execute(sql_query)
     @display_screen = 'basket_display'
   else
     @display_screen = 'basket_display_error'
     sql_query = 'select item_code from c3dss.dim_item
                   where upc = \'' + params[:upc] + '\'
                      or item_code = \'' + params[:upc] + '\'
                 '
     result = ActiveRecord::Base.connection.select_value(sql_query)

     if result != nil
       @order_number = params[:upc] + ' Item Code: ' + result
     else
       @order_number = 'No such item or upc in system: ' + params[:upc]
     end

   end

   render :allocate

 rescue Exception => exc
   logger.error("Message for the log file #{exc.message}")
   flash[:notice] = "Error message #{exc.message}"
 end

  def index
    @allocation_order_lines = AllocationOrderLine.each(params[:order_num])
  end


  def show
    @allocation_order_lines = AllocationOrderLine.find_by(params[:order_num])
  end

end
