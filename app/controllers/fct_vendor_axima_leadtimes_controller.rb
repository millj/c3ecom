class FctVendorAximaLeadtimesController < ApplicationController

  def show
    @fct_vendor_axima_leadtimes = FctVendorAximaLeadtime.find(params[:vendor_code])
  end

  def index
    @fct_vendor_axima_leadtimes = FctVendorAximaLeadtime.search(params[:search], params[:page])
  end

end
