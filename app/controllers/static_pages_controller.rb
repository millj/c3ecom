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

    redirect_to load_path

  end


end
