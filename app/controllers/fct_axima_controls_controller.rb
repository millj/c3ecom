class FctAximaControlsController < ApplicationController

  def show
    @fct_axima_controls = FctAximaControl.find(params[:id])
  end

  def index
    @fct_axima_controls = FctAximaControl.search(params[:search], params[:page])
  end

  def place_on_hold  purchase_order_no

  end

  def remove_from_hold  purchase_order_no

  end



end
