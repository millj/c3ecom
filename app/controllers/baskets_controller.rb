class BasketsController < ApplicationController

  def index
    if  params[:search].nil?
      @baskets = Basket.paginate(:page => params[:page], :per_page => 25)
    else
      @baskets = Basket.search(params[:search], params[:page])
    end

  end

  def new
    @basket = Basket.new
  end

  def create
    @basket = Basket.new(basket_params)
    if @basket.save
      flash[:success] = "New Basket added"
      redirect_to baskets_url
    else
      render 'new'
    end
  end


  def destroy
    @basket = Basket.find(params[:id])
    @basket.destroy

    flash[:success] = "Basket ##{@basket.basket_num} removed"
    redirect_to(:back)
  end

  def edit
    @basket = Basket.find(params[:id])
  end

  def update
    @basket = Basket.find(params[:id])

    respond_to do |format|
      if @basket.update_attributes(basket_params)
        flash[:success] = "Basket ##{@basket.basket_num} was successfully updated"
        format.html { redirect_to baskets_url }
        format.xml { head :ok }
      else
        format.html { render :action => "edit" }
      end
  end


  end

  private

  def basket_params
    params.require(:basket).permit(:order_num, :basket_num)
  end

end
