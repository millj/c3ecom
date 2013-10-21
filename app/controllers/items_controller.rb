class ItemsController < ApplicationController


  def show
    @items = Item.find(params[:item_code])
  end


  def index
    @items = Item.search(params[:search], params[:page])
  end
  

  end