class FctStartrackConnoteManualController < ApplicationController

  def show
    @fct_startrack_connote_manual = FctStartrackConnoteManual.find(params[:id])
  end

  def index
    @fct_startrack_connote_manual = FctStartrackConnoteManual.search(params[:search], params[:page])
  end


end
