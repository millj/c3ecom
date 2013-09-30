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
    flash[:success] = 'bugger'

  end

  def table_truncate
      flash[:success] = params[:id]
      sql_query = "truncate table c3demand.temp_josh"
      ActiveRecord::Base.connection.execute(sql_query)

  end


end
