require 'net/http'
require 'uri'

class StaticPagesController < ApplicationController


  def home
  end

  def help
  end

  def about

  end

  def contact

  end


  def truncate

  end

  def select_oms

    # run the xaction to get the list of currently available orders
    uri = URI.parse('http://dss.ccubed.local:8084/pentaho/ViewAction')
    params = { :solution => 'CFC', :action =>'mbecom_retrieve_available_orders_list.xaction', :path => '', :userid => 'report', :password => 'report' }
    uri.query = URI.encode_www_form(params)
    res = Net::HTTP.get_response(uri)

    # use rails to process the json in the incoming table into the mb_order_status table

    sql_query2 = 'SELECT available_orders_json from mbecom.mb_available_orders_incoming'
    incoming_json = ActiveRecord::Base.connection.select_value(sql_query2)

    # check to ensure there is json data to iterate through

    unless incoming_json.nil?

      json_to_process = ActiveSupport::JSON.decode(incoming_json)
      json_to_process.each do |json_data|
        sql_query3 = 'insert into mbecom.mb_order_status(order_id, order_number, order_ecom_status) values (' + '\'' + json_data['OrderGuid'] + '\', ' + '\'' + json_data['OrderReference'] + '\', ' + '\'' + '1' + '\'' + ') on duplicate key update order_id = order_id '
        ActiveRecord::Base.connection.execute(sql_query3)
      end

    end

    # Get orders ready to select
    sql_query1 = 'select *, false as order_selected from mbecom.mb_order_status where order_ecom_status = 1 order by priority desc, order_number'

    #load into table
    @order_choice = ActiveRecord::Base.connection.select_all(sql_query1)


  end

  def select_oms_orders


    #update selected orders as being ready to retrieve
    selected_order_ids = params[:selected]
    unless selected_order_ids.nil?

      selected_order_ids.each do |order_no|
        sql_query1 = 'update mbecom.mb_order_status  a
                      set a.order_ecom_status = 2
                      where a.order_number = ' + '\'' + order_no + '\'' +
            '    and a.order_ecom_status = 1'
        ActiveRecord::Base.connection.execute(sql_query1)
      end

      # retrieve order details that have been selected

      uri = URI.parse('http://dss.ccubed.local:8084/pentaho/ViewAction')
      params = { :solution => 'CFC', :action =>'mbecom_retrieve_order_details.xaction', :path => '', :userid => 'report', :password => 'report' }
      uri.query = URI.encode_www_form(params)
      res = Net::HTTP.get_response(uri)

      # orders now in DSS, time to break out, if mysql or Pentaho had better json handling we would do it there
      sql_query3 = 'truncate table mbecom.mb_order_details_incoming_single'
      ActiveRecord::Base.connection.execute(sql_query3)

      sql_query3 = 'select order_details_blob from mbecom.mb_order_details_incoming'
      incoming_json = ActiveRecord::Base.connection.select_value(sql_query3)
      #grab all
      unless incoming_json.nil?
        json_to_process = ActiveSupport::JSON.decode(incoming_json)
        json_to_process.each do |json_data|
          #now we have each order
          sql_query3 = 'insert into mbecom.mb_order_details_incoming_single(order_detail_record) values (' + '\'' + json_data.to_json + '\'' + ')'
          ActiveRecord::Base.connection.execute(sql_query3)
          order_guid = json_data['OrderGuid']
          order_line = json_data['OrderItems']
          unless order_line.nil?
            order_line.each do |one_order|
              # now we have each line
              sql_query4 = 'insert into mbecom.mb_order_line(order_guid,
                                                             item_upc,
                                                             item_name,
                                                             item_type,
                                                             order_item_status,
                                                             description,
                                                             qty_ordered,
                                                             qty_allocated,
                                                             qty_back_ordered,
                                                             qty_shipped,
                                                             qty_returned,
                                                             qty_wo,
                                                             unit_price,
                                                             tax_rate,
                                                             discount,
                                                             net_total,
                                                             gross_total,
                                                             discount_code,
                                                             discount_message,
                                                             is_gift_wrapped
                                                            ) values
                                                            ('
                                                          + '\'' + json_data['OrderGuid'] + '\', '
                                                          + '\'' + one_order['ItemUpc'] + '\', '
                                                          + '\'' + one_order['ItemName'] + '\', '
                                                          + '\'' + one_order['ItemType'] + '\', '
                                                          + '\'' + one_order['OrderItemStatus'] + '\', '
                                                          + '\'' + one_order['Description'] + '\', '
                                                          + '\'' + one_order['QuantityOrdered'] + '\', '
                                                          + '\'' + one_order['QuantityAllocated'] + '\', '
                                                          + '\'' + one_order['QuantityBackOrdered'] + '\', '
                                                          + '\'' + one_order['QuantityShipped'] + '\', '
                                                          + '\'' + one_order['Quantityreturned'] + '\', '
                                                          + '\'' + one_order['QuantityWrittenOff'] + '\', '
                                                          + '\'' + one_order['UnitPrice'] + '\', '
                                                          + '\'' + one_order['TaxRate'] + '\', '
                                                          + '\'' + one_order['Discount'] + '\', '
                                                          + '\'' + one_order['NetTotal'] + '\', '
                                                          + '\'' + one_order['GrossTotal'] + '\', '
                                                          + '\'' + one_order['DiscountCode'] + '\', '
                                                          + '\'' + one_order['DiscountMessage'] + '\', '
                                                          + '\'' + one_order['IsGiftWrapped'] + '\', '
                                                          + ')'
              ActiveRecord::Base.connection.execute(sql_query4)
            end
          end
        end

      end

    end
    redirect_to '/'

  end

  def table_truncate_mecca

      sql_query = "truncate table " + params[:select_table]
      ActiveRecord::Base.connection.execute(sql_query)
      flash[:success] = 'Truncated ' + params[:select_table]
      redirect_to truncate_path
  rescue Exception => exc
    logger.error("Message for the log file #{exc.message}")
    flash[:notice] = "Error #{exc.message}"
    redirect_to truncate_mecca_path
  end

  def table_truncate_km

    sql_query = "truncate table " + params[:select_table]
    ActiveRecord::Base.connection.execute(sql_query)
    flash[:success] = 'Truncated ' + params[:select_table]
    redirect_to truncate_path
  rescue Exception => exc
    logger.error("Message for the log file #{exc.message}")
    flash[:notice] = "Error #{exc.message}"
    redirect_to truncate_km_path
  end

  def table_truncate

    sql_query = "truncate table " + params[:select_table]
    ActiveRecord::Base.connection.execute(sql_query)
    flash[:success] = 'Truncated ' + params[:select_table]
    redirect_to truncate_path
  rescue Exception => exc
    logger.error("Message for the log file #{exc.message}")
    flash[:notice] = "Error #{exc.message}"
    redirect_to truncate_path
  end

  def load

  end

  def live_table_mecca

    sql_query = 'insert into ' + params[:select_table] + ' select * from ' + params[:select_table] + '_upload'
    ActiveRecord::Base.connection.execute(sql_query)
    flash[:success] = 'Loaded ' + params[:select_table]
    redirect_to live_load_mecca_path
  rescue Exception => exc
    logger.error("Message for the log file #{exc.message}")
    flash[:notice] = "Error #{exc.message}"
    redirect_to live_load_mecca_path

  end

  def live_table_km

    sql_query = 'insert into ' + params[:select_table] + ' select * from ' + params[:select_table] + '_upload'
    ActiveRecord::Base.connection.execute(sql_query)
    flash[:success] = 'Loaded ' + params[:select_table]
    redirect_to live_load_km_path
  rescue Exception => exc
    logger.error("Message for the log file #{exc.message}")
    flash[:notice] = "Error #{exc.message}"
    redirect_to live_load_km_path

  end

  def load_table_mecca

    sql_query =  'truncate table ' + params[:select_table]
    ActiveRecord::Base.connection.execute(sql_query)

    sql_query =  'load data infile \'/mnt/integration/demand/' + params[:select_table][((params[:select_table].index('.')) + 1)..(params[:select_table].length)] + '.csv \' into table ' + params[:select_table] + ' fields terminated by \',\' optionally enclosed by \'\"\' lines terminated by  \'\\r\\n\' ignore 1 lines'
    ActiveRecord::Base.connection.execute(sql_query)
    flash[:success] = 'Loaded ' + params[:select_table]
    redirect_to load_mecca_path
  rescue Exception => exc
    logger.error("Message for the log file #{exc.message}")
    flash[:notice] = "Error #{exc.message}"
    redirect_to load_mecca_path

  end

  def load_table_km

    sql_query =  'truncate table ' + params[:select_table]
    ActiveRecord::Base.connection.execute(sql_query)

    sql_query =  'load data infile \'/mnt/integration/demand/' + params[:select_table][((params[:select_table].index('.')) + 1)..(params[:select_table].length)] + '.csv \' into table ' + params[:select_table] + ' fields terminated by \',\' optionally enclosed by \'\"\' lines terminated by  \'\\r\\n\' ignore 1 lines'
    ActiveRecord::Base.connection.execute(sql_query)
    flash[:success] = 'Loaded ' + params[:select_table]
    redirect_to load_km_path
  rescue Exception => exc
    logger.error("Message for the log file #{exc.message}")
    flash[:notice] = "Error #{exc.message}"
    redirect_to load_km_path

  end

  def load_table

    sql_query = 'load data infile \'/mnt/integration/demand/' + params[:select_table][((params[:select_table].index('.')) + 1)..(params[:select_table].length)] + '.csv \' into table ' + params[:select_table] + ' fields terminated by \',\' optionally enclosed by \'\"\' lines terminated by  \'\\r\\n\' ignore 1 lines'
    ActiveRecord::Base.connection.execute(sql_query)
    flash[:success] = 'Loaded ' + params[:select_table]
    redirect_to load_path
  rescue Exception => exc
    logger.error("Message for the log file #{exc.message}")
    flash[:notice] = "Error #{exc.message}"
    redirect_to load_path

  end

  def load_table_finance
    sql_query = 'load data infile \'/mnt/integration/finance/' + params[:select_table][((params[:select_table].index('.')) + 1)..(params[:select_table].length)] + '.csv \' into table ' + params[:select_table] + ' fields terminated by \',\' optionally enclosed by \'\"\' lines terminated by  \'\\r\\n\' ignore 1 lines'
    ActiveRecord::Base.connection.execute(sql_query)
    flash[:success] = 'Loaded ' + params[:select_table]
    redirect_to load_finance_path
  rescue Exception => exc
    logger.error("Message for the log file #{exc.message}")
    flash[:notice] = "Error #{exc.message}"
    redirect_to load_finance_path
  end

  def truncate_table_finance
    sql_query = "truncate table " + params[:select_table]
    ActiveRecord::Base.connection.execute(sql_query)
    flash[:success] = 'Truncated ' + params[:select_table]
    redirect_to truncate_finance_path
  rescue Exception => exc
    logger.error("Message for the log file #{exc.message}")
    flash[:notice] = "Error #{exc.message}"
    redirect_to truncate_finance_path
  end

  def load_shopper

  end

  def load_secret_shopper

    sql_query =  'load data infile \'/mnt/integration/secretshopper/' + params[:select_table][((params[:select_table].index('.')) + 1)..(params[:select_table].length)] + '.csv \' into table ' + params[:select_table] + ' fields terminated by \',\' optionally enclosed by \'\"\' lines terminated by  \'\\r\\n\' ignore 1 lines'
    ActiveRecord::Base.connection.execute(sql_query)
    flash[:success] = 'Loaded ' + params[:select_table]
    redirect_to load_secret_shopper
  rescue Exception => exc
    logger.error("Message for the log file #{exc.message}")
    flash[:notice] = "Error #{exc.message}"
    redirect_to load_secret_shopper

  end


end
