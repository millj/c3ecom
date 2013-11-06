class FctStorePickScansController < ApplicationController

  def create
    @fct_store_pick_scans = FctStorePickScan.new(fct_store_pick_scans_params)
    if @fct_store_pick_scans.save
      flash[:success] = "Scan added"
      redirect_to @fct_store_pick_scans
    else
      render 'new'
    end
  end

  def new
    @fct_store_pick_scans = FctStorePickScan.new
  end

  def edit
    @fct_store_pick_scans = FctStorePickScan.find(params[:id])
  end

  def show
    @fct_store_pick_scans = FctStorePickScan.find(params[:id])
  end

  def update
    @fct_store_pick_scans = FctStorePickScan.find(params[:id])
    if @fct_store_pick_scans.update_attributes(fct_store_pick_scans_params)
      flash[:success] = "Scan updated"
      redirect_to @fct_store_pick_scans
    else
      render 'edit'
    end
  end

  def destroy
    FctStorePickScan.find(params[:id]).destroy
    flash[:success] = "Scan removed"
    redirect_to fct_store_pick_scans_path
  end

  def index
    @fct_store_pick_scans = FctStorePickScan.search(params[:search], params[:page])
  end

  private

    def fct_store_pick_scans_params
      params.require(:fct_store_pick_scan).permit(:store_code, :pick_date, :wpi_code, :wsn_code, :start_time, :end_time, :picked_by, :checked_by, :scanned_by)
    end
end
