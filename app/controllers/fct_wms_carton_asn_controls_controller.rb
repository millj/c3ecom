class FctWmsCartonAsnControlsController < ApplicationController

  def show
    @fct_wms_carton_asn_controls = FctWmsCartonAsnControl.find(params[:id])
  end

  def index
    @fct_wms_carton_asn_controls = FctWmsCartonAsnControl.search(params[:search], params[:page])
  end


end
