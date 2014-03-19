class FctVendorAximaLeadtimesController < ApplicationController

  def show
    @fct_vendor_axima_leadtimes = FctVendorAximaLeadtime.find_by_vendor_code(params[:id])
  end

  def index
    @fct_vendor_axima_leadtimes = FctVendorAximaLeadtime.search(params[:search], params[:page])
  end

  def edit
    @fct_vendor_axima_leadtimes = FctVendorAximaLeadtime.find_by_vendor_code(params[:id])
  end

  def new
    @fct_vendor_axima_leadtimes  = FctVendorAximaLeadtime.new
  end

  def create
    @fct_vendor_axima_leadtimes = FctVendorAximaLeadtime.new(fct_vendor_axima_leadtimes_params)
    if @fct_vendor_axima_leadtimes.save
      flash[:success] = "Vendor Lead time added"
      redirect_to @fct_vendor_axima_leadtimes
    else
      render 'new'
    end
  end

  def update
    @fct_vendor_axima_leadtimes = FctVendorAximaLeadtime.find_by_vendor_code(params[:id])
    if @fct_vendor_axima_leadtimes.update_attributes(fct_vendor_axima_leadtimes_params)
      flash[:success] = "Lead Time updated"
      redirect_to @fct_vendor_axima_leadtimes
    else
      render 'edit'
    end
  end

  def destroy
    FctVendorAximaLeadtime.find(params[:id]).destroy
    flash[:success] = "Lead time removed"
    redirect_to fct_vendor_axima_leadtimes_path
  end


  private

  def fct_vendor_axima_leadtimes_params
    params.require(:fct_vendor_axima_leadtime).permit(:vendor_code, :lead_time_days)
  end

end
