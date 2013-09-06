class DirectBinContentsController < ApplicationController

  def create
    @direct_bin_contents = DirectBinContent.new(direct_bin_contents_params)
    if @direct_bin_contents.save
      flash[:success] = "Item added"
      redirect_to @direct_bin_contents
    else
      render 'new'
    end
  end

  def new
    @direct_bin_contents = DirectBinContent.new
  end

  def edit
    @direct_bin_contents = DirectBinContent.find(params[:id])
  end

  def show
    @direct_bin_contents = DirectBinContent.find(params[:id])
  end

  def update
    @direct_bin_contents = DirectBinContent.find(params[:id])
    if @direct_bin_contents.update_attributes(direct_bin_contents_params)
      flash[:success] = "Item updated"
      redirect_to @direct_bin_contents
    else
      render 'edit'
    end
  end

  def destroy
    DirectBinContent.find(params[:id]).destroy
    flash[:success] = "Item removed"
    redirect_to direct_bin_contents_path
  end

  def index
    @direct_bin_contents = DirectBinContent.search(params[:search], params[:page])
  end

  private

    def direct_bin_contents_params
      params.require(:direct_bin_content).permit(:bin_name, :item_code)
    end
end
