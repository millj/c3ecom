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

    # Get orders ready to select
    sql_query1 = 'select *, false as order_selected from mbecom.order_status where order_ecom_status = 1'

    #load into table
    @order_choice = ActiveRecord::Base.connection.select_all(sql_query1)





  end

  def select_oms_orders

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
