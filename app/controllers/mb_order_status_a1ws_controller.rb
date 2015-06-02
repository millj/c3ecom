class MbOrderStatusA1wsController < ApplicationController


  def show
   # @mb_order_status_a1ws = MbOrderStatusA1w.find(params[:order_number])
    sql_query1 = 'select
                   a.order_number,
                   a.priority,
                   substring(b.delivery_instructions, 1, 100) as special_instructions,
                   c.sscc
                  from mbecom.mb_order_status_a1w a
                    left join mbecom.mb_shipping_address_a1w b
                      on b.order_guid = a.order_guid
                    left join mbecom.fct_totmastr_details c
                      on c.order_num = a.order_number '
    @mb_order_status_a1ws = ActiveRecord::Base.connection.select_all(sql_query1)
  end


  def index
    # @mb_order_status_a1ws = MbOrderStatusA1w.search(params[:search], params[:page])
    sql_query1 = 'select
                   a.order_number,
                   a.priority,
                   b.delivery_instructions,
                   c.sscc
                  from mbecom.mb_order_status_a1w a
                    left join mbecom.mb_shipping_address_a1w b
                      on b.order_guid = a.order_guid
                    left join mbecom.fct_totmastr_details c
                      on c.order_num = a.order_number '
    @mb_order_status_a1ws = ActiveRecord::Base.connection.select_all(sql_query1)

  end
  

  end