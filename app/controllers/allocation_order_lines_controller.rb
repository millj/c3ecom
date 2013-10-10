class AllocationOrderLinesController < ApplicationController

 def allocate_item

   sql_query = 'select a.order_num
                   from c3rails_dev.allocation_orders a,
                        c3rails_dev.allocation_order_lines b
                   where b.order_num = a.order_num
                     and b.upc = \'' + params[:upc] + '\'
                     and b.qty_scanned < b.qty_required
                    order by a.order_priority desc, a.order_date desc limit 1'
   result = ActiveRecord::Base.connection.select_value(sql_query)
   @basket_number = result

   sql_query = 'update c3rails_dev.allocation_order_lines b
                   set b.qty_scanned = b.qty_scanned + 1

                   where b.order_num = \'' + @basket_number + '\'
                     and b.upc = \'' + params[:upc] + '\'
                     and b.qty_scanned < b.qty_required'
   ActiveRecord::Base.connection.execute(sql_query)

   render :allocate
 rescue Exception => exc
   logger.error("Message for the log file #{exc.message}")
   flash[:notice] = "Store error message #{exc.message}"
 end

  def index

  end

  def show

  end

end
