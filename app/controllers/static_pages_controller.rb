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
      flash[:success] = params[:id]
      sql_query = "truncate table c3demand." + params[:id]
      ActiveRecord::Base.connection.execute(sql_query)
      redirect_to truncate_path
  end


end
