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
   flash[:notice] =  params[:id]

   redirect_to truncate_path
  end

end
