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

  def table_truncate
      flash[:success] = 'Truncating ' + params[:select_table]
      sql_query = "truncate table " + params[:select_table]
      ActiveRecord::Base.connection.execute(sql_query)
      redirect_to truncate_path
  end

  def load

  end

  def load_table
    flash[:success] = 'Loading' + params[:select_table]
    sql_query =  'load data infile \'/tmp/' + params[:select_table][9..(params[:select_table].length)] + '.csv \' into table ' + params[:select_table] + ' fields terminated by \',\' ignore 1 lines'
    ActiveRecord::Base.connection.execute(sql_query)
    redirect_to load_path

  end


end
