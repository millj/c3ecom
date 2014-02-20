class FctAximaControlController < ApplicationController

  def show
    @fct_axima_control = FctAximaControl.find(params[:id])
  end

  def index
    @fct_axima_control = FctAximaControl.search(params[:search], params[:page])
  end


end
