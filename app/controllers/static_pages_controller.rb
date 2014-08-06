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

  def ship_the_parcel
    selected_order_ids = params[:selected]
    unless selected_order_ids.nil?
      selected_order_ids.each do |order_no|
        sql_query1 = 'update mbecom.mb_order_status  a
                      set a.order_ecom_status = 42
                      where a.order_number = ' + '\'' + order_no + '\'' +
            '    and a.order_ecom_status = 41'
        ActiveRecord::Base.connection.execute(sql_query1)
      end
    end

    # add in ship call to api

    redirect_to '/'
  end

  def ship_the

    uri = URI.parse('http://dss.ccubed.local:8084/pentaho/ViewAction')
    params = { :solution => 'CFC', :action =>'mbecom_update_connote.xaction', :path => '', :userid => 'report', :password => 'report' }
    uri.query = URI.encode_www_form(params)
    res = Net::HTTP.get_response(uri)

    sql_query1 = 'select * from mbecom.mb_order_status where order_ecom_status = 41'
    @ship_orders = ActiveRecord::Base.connection.select_all(sql_query1)
  end

  def dispatch_the_parcel

    selected_order_ids = params[:selected]
    unless selected_order_ids.nil?
      selected_order_ids.each do |order_no|
        sql_query1 = 'update mbecom.mb_order_status  a
                      set a.order_ecom_status = 31
                      where a.order_number = ' + '\'' + order_no + '\'' +
            '    and a.order_ecom_status = 30'
        ActiveRecord::Base.connection.execute(sql_query1)
      end
      uri = URI.parse('http://dss.ccubed.local:8084/pentaho/ViewAction')
      params = { :solution => 'CFC', :action =>'mbecom_dispatch_orders.xaction', :path => '', :userid => 'report', :password => 'report' }
      uri.query = URI.encode_www_form(params)
      res = Net::HTTP.get_response(uri)

    end
    sql_query1 = 'update mbecom.mb_order_status  a
                      set a.order_ecom_status = 40
                      where a.order_ecom_status = 31'
    ActiveRecord::Base.connection.execute(sql_query1)
    redirect_to '/'
  end

  def dispatch_the

    sql_query1 = 'select * from mbecom.mb_order_status where order_ecom_status = 30'
    @dispatch_orders = ActiveRecord::Base.connection.select_all(sql_query1)

  end

  def reprint_gift_message

    selected_order_ids = params[:selected]
    unless selected_order_ids.nil?
      selected_order_ids.each do |order_no|
        sql_query1 = 'update mbecom.mb_order_status a
                      set a.printed_message = a.printed_message + 1
                      where a.order_number = ' + '\'' + order_no + '\''
        ActiveRecord::Base.connection.execute(sql_query1)

        sql_query1 = 'insert into mbecom.mb_print_me(order_number) values ( ' + '\'' + order_no + '\'' + ')'
        ActiveRecord::Base.connection.execute(sql_query1)

        uri = URI.parse('http://dss.ccubed.local:8084/pentaho/ViewAction')
        params = { :solution => 'CFC', :action =>'mbecom_print_gift.xaction', :path => '', :userid => 'report', :password => 'report' }
        uri.query = URI.encode_www_form(params)
        res = Net::HTTP.get_response(uri)

        sql_query1 = 'truncate table mbecom.mb_print_me'
        ActiveRecord::Base.connection.execute(sql_query1)
      end
    end
    redirect_to '/'

  end

  def reprint_gift

    sql_query1 = 'select * from mbecom.mb_order_header a, mbecom.mb_order_status b where length(gift_message) > 0 and b.order_guid = a.order_guid order by b.order_number desc'
    @gift_message = ActiveRecord::Base.connection.select_all(sql_query1)

  end

  def print_gift_message
    selected_order_ids = params[:selected]
    unless selected_order_ids.nil?
      selected_order_ids.each do |order_no|
        sql_query1 = 'update mbecom.mb_order_status a
                      set a.printed_message = a.printed_message + 1
                      where a.order_number = ' + '\'' + order_no + '\''
        ActiveRecord::Base.connection.execute(sql_query1)

        sql_query1 = 'insert into mbecom.mb_print_me(order_number) values ( ' + '\'' + order_no + '\'' + ')'
        ActiveRecord::Base.connection.execute(sql_query1)

        uri = URI.parse('http://dss.ccubed.local:8084/pentaho/ViewAction')
        params = { :solution => 'CFC', :action =>'mbecom_print_gift.xaction', :path => '', :userid => 'report', :password => 'report' }
        uri.query = URI.encode_www_form(params)
        res = Net::HTTP.get_response(uri)

        sql_query1 = 'truncate table mbecom.mb_print_me'
        ActiveRecord::Base.connection.execute(sql_query1)
      end
    end
    redirect_to '/'
  end

  def print_gift

    sql_query1 = 'select * from mbecom.mb_order_header a, mbecom.mb_order_status b where length(gift_message) > 0 and b.order_guid = a.order_guid and b.printed_message = 0 order by b.order_number'
    @gift_message = ActiveRecord::Base.connection.select_all(sql_query1)

  end

  def select_bulk

    # Get orders ready to select, by default check 10 orders to bulk at a time
    sql_query1 = 'select
     a.*,
     @rownum:= @rownum + 1 as rank,
     case when @rownum <= 10 then true else false end as order_selected
     from mbecom.mb_order_status a, (select @rownum := 0) r
    where order_ecom_status = 10
    order by priority desc, order_number'

    #load into table
    @bulk_pick_choice = ActiveRecord::Base.connection.select_all(sql_query1)



  end


  def select_bulk_pick

    selected_order_ids = params[:selected]
    unless selected_order_ids.nil?

      selected_order_ids.each do |order_no|
        sql_query1 = 'update mbecom.mb_order_status  a
                      set a.order_ecom_status = 11
                      where a.order_number = ' + '\'' + order_no + '\'' +
            '    and a.order_ecom_status = 10'
        ActiveRecord::Base.connection.execute(sql_query1)
      end
      # Call the pentaho job to print the bulk print list
      uri = URI.parse('http://dss.ccubed.local:8084/pentaho/ViewAction')
      params = { :solution => 'CFC', :action =>'mbecom_print_bulk_order.xaction', :path => '', :userid => 'report', :password => 'report' }
      uri.query = URI.encode_www_form(params)
      res = Net::HTTP.get_response(uri)

      selected_order_ids.each do |order_no|
        sql_query1 = 'update mbecom.mb_order_status  a
                      set a.order_ecom_status = 30
                      where a.order_number = ' + '\'' + order_no + '\'' +
            '    and a.order_ecom_status = 13'
        ActiveRecord::Base.connection.execute(sql_query1)
      end

    end

    redirect_to '/'
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

    sql_query2 = 'SELECT http_status_code from mbecom.mb_available_orders_incoming'
    http_status = ActiveRecord::Base.connection.select_value(sql_query2)
    # check to ensure there is json data to iterate through
    if http_status == '200'
      unless incoming_json.nil?

        json_to_process = ActiveSupport::JSON.decode(incoming_json)
        json_to_process.each do |json_data|
          sql_query3 = 'insert into mbecom.mb_order_status(order_guid, order_number, order_ecom_status) values (' + '\'' + json_data['OrderGuid'] + '\', ' + '\'' + json_data['OrderReference'] + '\', ' + '\'' + '1' + '\'' + ') on duplicate key update order_guid = order_guid '
          ActiveRecord::Base.connection.execute(sql_query3)
        end
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

      # Lock orders that we wish to retrieve

      uri = URI.parse('http://dss.ccubed.local:8084/pentaho/ViewAction')
      params = { :solution => 'CFC', :action =>'mb_lock_orders.xaction', :path => '', :userid => 'report', :password => 'report' }
      uri.query = URI.encode_www_form(params)
      res = Net::HTTP.get_response(uri)

      # retrieve order details that have been selected

      uri = URI.parse('http://dss.ccubed.local:8084/pentaho/ViewAction')
      params = { :solution => 'CFC', :action =>'mbecom_retrieve_order_details.xaction', :path => '', :userid => 'report', :password => 'report' }
      uri.query = URI.encode_www_form(params)
      res = Net::HTTP.get_response(uri)

      #check the http status of the request, saved in table with the json
      sql_query = 'Select http_status_code from mbecom.mb_order_details_incoming'
      http_status =  ActiveRecord::Base.connection.select_value(sql_query)

      if http_status == '200' then
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

            # do header
            sql_query5 = 'insert into mbecom.mb_order_header (order_guid,
                                                            order_ref,
                                                            customer_ref,
                                                            customer_name,
                                                            customer_email,
                                                            channel_guid,
                                                            channel_code,
                                                            order_date,
                                                            order_status,
                                                            order_type,
                                                            payment_total,
                                                            tax_total,
                                                            gross_total,
                                                            net_total,
                                                            gift_message) values (' +
                '\'' + json_data['OrderGuid'].to_s + '\', ' +
                '\'' + json_data['OrderReference'].to_s + '\', ' +
                '\'' + json_data['Customer']['CustomerReference'].to_s + '\', ' +
                '\'' + json_data['Customer']['CustomerName'].to_s + '\', ' +
                '\'' + json_data['Customer']['CustomerEmail'].to_s + '\', ' +
                '\'' + json_data['ChannelGuid'].to_s + '\', ' +
                '\'' + json_data['ChannelCode'].to_s + '\', ' +
                '\'' + json_data['OrderDate'].to_s + '\', ' +
                '\'' + json_data['OrderStatus'].to_s + '\', ' +
                '\'' + json_data['OrderType'].to_s + '\', ' +
                '\'' + json_data['PaymentTotal'].to_s + '\', ' +
                '\'' + json_data['TaxTotal'].to_s + '\', ' +
                '\'' + json_data['GrossTotal'].to_s + '\', ' +
                '\'' + json_data['NetTotal'].to_s + '\', ' +
                '\'' + json_data['GiftMessage'].to_s + '\'' +
                ')'
            ActiveRecord::Base.connection.execute(sql_query5)
            #change order status in c3ecom
            sql_query6 = 'update mbecom.mb_order_status  a
                          set a.order_ecom_status = 3
                          where a.order_guid = ' + '\'' + json_data['OrderGuid'].to_s + '\'' +
                '    and a.order_ecom_status = 2'
            ActiveRecord::Base.connection.execute(sql_query6)

            sql_query3 = 'insert into mbecom.mb_order_details_incoming_single(order_detail_record) values (' + '\'' + json_data.to_json + '\'' + ')'
            ActiveRecord::Base.connection.execute(sql_query3)
            order_guid = json_data['OrderGuid']
            order_line = json_data['OrderItems']

            #do lines
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
                                                             discount_message
                                                            ) values
                                                            (' +
                    '\'' + order_guid + '\', ' +
                    '\'' + one_order['ItemUpc'].to_s + '\', ' +
                    '\'' + one_order['ItemName'].to_s + '\', ' +
                    '\'' + one_order['ItemType'].to_s + '\', '  +
                    '\'' + one_order['OrderItemStatus'].to_s + '\', ' +
                    '\'' + one_order['Description'].to_s + '\', ' +
                    '\'' + one_order['QuantityOrdered'].to_s + '\', ' +
                    '\'' + one_order['QuantityAllocated'].to_s + '\', ' +
                    '\'' + one_order['QuantityBackOrdered'].to_s + '\', ' +
                    '\'' + one_order['QuantityShipped'].to_s + '\', ' +
                    '\'' + one_order['QuantityReturned'].to_s + '\', ' +
                    '\'' + one_order['QuantityWrittenOff'].to_s + '\', ' +
                    '\'' + one_order['UnitPrice'].to_s + '\', ' +
                    '\'' + one_order['TaxRate'].to_s + '\', ' +
                    '\'' + one_order['Discount'].to_s + '\', ' +
                    '\'' + one_order['NetTotal'].to_s + '\', ' +
                    '\'' + one_order['GrossTotal'].to_s + '\', ' +
                    '\'' + one_order['DiscountCode'].to_s + '\', ' +
                    '\'' + one_order['DiscountMessage'].to_s + '\'' +
                    ')'
                ActiveRecord::Base.connection.execute(sql_query4)
              end
            end
            sql_query7 = 'update mbecom.mb_order_status  a
                          set a.order_ecom_status = 4
                          where a.order_guid = ' + '\'' + json_data['OrderGuid'].to_s + '\'' +
                '    and a.order_ecom_status = 3'
            ActiveRecord::Base.connection.execute(sql_query7)

            # do shipping adddress
            unless json_data['ShippingAddress'].nil?
              sql_query8 = 'insert into mbecom.mb_shipping_address (order_guid,
                                                                first_name,
                                                                last_name,
                                                                address1,
                                                                address2,
                                                                city,
                                                                postcode,
                                                                state,
                                                                country,
                                                                phone,
                                                                delivery_instructions
                                                               ) values (' +
                  '\'' + json_data['OrderGuid'].to_s + '\', ' +
                  '\'' + json_data['ShippingAddress']['FirstName'].to_s + '\', ' +
                  '\'' + json_data['ShippingAddress']['LastName'].to_s + '\', ' +
                  '\'' + json_data['ShippingAddress']['Address1'].to_s + '\', ' +
                  '\'' + json_data['ShippingAddress']['Address2'].to_s + '\', ' +
                  '\'' + json_data['ShippingAddress']['City'].to_s + '\', ' +
                  '\'' + json_data['ShippingAddress']['PostalCode'].to_s + '\', ' +
                  '\'' + json_data['ShippingAddress']['State'].to_s + '\', ' +
                  '\'' + json_data['ShippingAddress']['Country'].to_s + '\', ' +
                  '\'' + json_data['ShippingAddress']['PhoneNumber'].to_s + '\', ' +
                  '\'' + json_data['ShippingAddress']['DeliveryInstructions'].to_s + '\'' +
                  ')'
              ActiveRecord::Base.connection.execute(sql_query8)
            end
            #change order status in c3ecom
            sql_query6 = 'update mbecom.mb_order_status  a
                          set a.order_ecom_status = 5
                          where a.order_guid = ' + '\'' + json_data['OrderGuid'].to_s + '\'' +
                '    and a.order_ecom_status = 4'
            ActiveRecord::Base.connection.execute(sql_query6)

            # do billing adddress
            unless json_data['BillingAddress'].nil?
              sql_query8 = 'insert into mbecom.mb_billing_address (order_guid,
                                                                first_name,
                                                                last_name,
                                                                address1,
                                                                address2,
                                                                city,
                                                                postcode,
                                                                state,
                                                                country,
                                                                phone
                                                               ) values (' +
                  '\'' + json_data['OrderGuid'].to_s + '\', ' +
                  '\'' + json_data['BillingAddress']['FirstName'].to_s + '\', ' +
                  '\'' + json_data['BillingAddress']['LastName'].to_s + '\', ' +
                  '\'' + json_data['BillingAddress']['Address1'].to_s + '\', ' +
                  '\'' + json_data['BillingAddress']['Address2'].to_s + '\', ' +
                  '\'' + json_data['BillingAddress']['City'].to_s + '\', ' +
                  '\'' + json_data['BillingAddress']['PostalCode'].to_s + '\', ' +
                  '\'' + json_data['BillingAddress']['State'].to_s + '\', ' +
                  '\'' + json_data['BillingAddress']['Country'].to_s + '\', ' +
                  '\'' + json_data['BillingAddress']['PhoneNumber'].to_s + '\'' +
                  ')'
              ActiveRecord::Base.connection.execute(sql_query8)
            end
            #change order status in c3ecom
            sql_query6 = 'update mbecom.mb_order_status  a
                          set a.order_ecom_status = 6
                          where a.order_guid = ' + '\'' + json_data['OrderGuid'].to_s + '\'' +
                '    and a.order_ecom_status = 5'
            ActiveRecord::Base.connection.execute(sql_query6)

            # do payments
            order_payment = json_data['OrderPayments']
            unless order_payment.nil?
              order_payment.each do |one_payment|
                # now we have each payment
                sql_query9 = 'insert into mbecom.mb_order_payments(order_guid,
                                                             payment_guid,
                                                             payment_type,
                                                             payment_status,
                                                             currency_code,
                                                             payment_method_ref,
                                                             payment_provider_ref,
                                                             payment_date,
                                                             amount,
                                                             authorised_amount,
                                                             fee
                                                            ) values
                                                            (' +
                    '\'' + order_guid + '\', ' +
                    '\'' + one_payment['PaymentGuid'].to_s + '\', ' +
                    '\'' + one_payment['PaymentType'].to_s + '\', ' +
                    '\'' + one_payment['PaymentStatus'].to_s + '\', '  +
                    '\'' + one_payment['IsoCurrencyCode'].to_s + '\', ' +
                    '\'' + one_payment['PaymentMethodReference'].to_s + '\', ' +
                    '\'' + one_payment['PaymentProviderReference'].to_s + '\', ' +
                    '\'' + one_payment['PaymentDate'].to_s + '\', ' +
                    '\'' + one_payment['Amount'].to_s + '\', ' +
                    '\'' + one_payment['AuthorisedAmount'].to_s + '\', ' +
                    '\'' + one_payment['Fee'].to_s + '\'' +
                    ')'
                ActiveRecord::Base.connection.execute(sql_query9)
              end
            end
            sql_query6 = 'update mbecom.mb_order_status  a
                          set a.order_ecom_status = 7
                          where a.order_guid = ' + '\'' + json_data['OrderGuid'].to_s + '\'' +
                '    and a.order_ecom_status = 6'
            ActiveRecord::Base.connection.execute(sql_query6)

            line_items = json_data['LineItems']
            unless line_items.nil?
              line_items.each do |one_line|
                sql_query = 'insert into mbecom.mb_order_line_other(order_guid,
                                                                    line_item_type,
                                                                    description,
                                                                    net_amount,
                                                                    tax_amount,
                                                                    gross_amount,
                                                                    shipping_provider,
                                                                    shipping_method) values
                                                                    (' +
                    '\'' + order_guid + '\', ' +
                    '\'' + one_line['OrderLineItemType'].to_s + '\', ' +
                    '\'' + one_line['Description'].to_s + '\', ' +
                    '\'' + one_line['NetAmount'].to_s + '\', '  +
                    '\'' + one_line['TaxAmount'].to_s + '\', ' +
                    '\'' + one_line['GrossAmount'].to_s + '\', ' +
                    '\'' + one_line['ShippingProviderReference'].to_s + '\', ' +
                    '\'' + one_line['ShippingMethodReference'].to_s + '\'' +
                    ')'
                ActiveRecord::Base.connection.execute(sql_query)
              end
            end

            sql_query6 = 'update mbecom.mb_order_status  a
                          set a.order_ecom_status = 8
                          where a.order_guid = ' + '\'' + json_data['OrderGuid'].to_s + '\'' +
                '    and a.order_ecom_status = 7'
            ActiveRecord::Base.connection.execute(sql_query6)

            gift_voucher_lines = json_data['GiftVoucherItems']
            unless gift_voucher_items.nil?
              gift_voucher_items.each do |gv_line|
                sql_query = 'insert into mbecom.mb_gift_voucher_items(order_guid,
                                                                    gv_guid,
                                                                    item_upc,
                                                                    buyer_name,
                                                                    receipient_name,
                                                                    receipient_email,
                                                                    item_message,
                                                                    amount) values
                                                                    (' +
                    '\'' + order_guid + '\', ' +
                    '\'' + one_line['GiftVoucherGuid'].to_s + '\', ' +
                    '\'' + one_line['GiftVoucherItemUpc'].to_s + '\', ' +
                    '\'' + one_line['BuyerName'].to_s + '\', '  +
                    '\'' + one_line['RecipientName'].to_s + '\', ' +
                    '\'' + one_line['RecipientEmail'].to_s + '\', ' +
                    '\'' + one_line['ItemMessage'].to_s + '\', ' +
                    '\'' + one_line['Amount'].to_s + '\'' +
                    ')'
                ActiveRecord::Base.connection.execute(sql_query)
              end
            end

            sql_query6 = 'update mbecom.mb_order_status  a
                          set a.order_ecom_status = 10
                          where a.order_guid = ' + '\'' + json_data['OrderGuid'].to_s + '\'' +
                '    and a.order_ecom_status = 8'
            ActiveRecord::Base.connection.execute(sql_query6)

            # All data loaded correctly, can set rpro status as ready to import
            sql_query6 = 'update mbecom.mb_order_status  a
                          set a.order_rpro_status = 1
                          where a.order_guid = ' + '\'' + json_data['OrderGuid'].to_s + '\'' +
                '    and a.order_rpro_status = 0 and a.order_ecom_status = 10'
            ActiveRecord::Base.connection.execute(sql_query6)

          end

        end
      else
        puts 'Http Status:'
        puts http_status
      end  # http_status = 200

    end # select_order_ids.nil?

    # Create RPRO files
    uri = URI.parse('http://dss.ccubed.local:8084/pentaho/ViewAction')
    params = { :solution => 'CFC', :action =>'mbecom_induct_orders_rpro.xaction', :path => '', :userid => 'report', :password => 'report' }
    uri.query = URI.encode_www_form(params)
    res = Net::HTTP.get_response(uri)

    redirect_to select_bulk_pick_path

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
