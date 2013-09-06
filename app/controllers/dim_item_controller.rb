class DimItem < ApplicationController

  def index
    @dim_item = DimItem.search(params[:search], params[:page])
  end

  def show

  end

end