class FctRproSosController < ApplicationController


  def show
    @fct_rpro_sos = fct_rpro_so.find(params[:so_sid])
  end


  def index
    @fct_rpro_sos = fct_rpro_so.search(params[:search], params[:page])
  end

  def sales_order
    if  params[:search].nil?
      @sales_order = FctRproSo.joins('left join c3dss.fct_sale on fct_rpro_so.invc_sid = fct_sale.invoice_sid').order('ecommerce_order_no desc').select('fct_rpro_so.*, fct_sale.receipt_number').paginate(:page => params[:page])
    else
      @sales_order = FctRproSo.joins('left join c3dss.fct_sale on fct_rpro_so.invc_sid = fct_sale.invoice_sid').order('ecommerce_order_no desc').select('fct_rpro_so.*, fct_sale.receipt_number').search(params[:search], params[:page])

    end
  end


  end