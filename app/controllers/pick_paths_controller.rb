class PickPathsController < ApplicationController

  def create
    @pick_paths = PickPath.new(pick_paths_params)
    if @pick_paths.save
      flash[:success] = "Bin added"
      redirect_to @pick_paths
    else
      render 'new'
    end
  end

  def new
    @pick_paths = PickPath.new
  end

  def edit
    @pick_paths = PickPath.find(params[:id])
  end

  def show
    @pick_paths = PickPath.find(params[:id])
  end

  def update
    @pick_paths = PickPath.find(params[:id])
    if @pick_paths.update_attributes(pick_paths_params)
      flash[:success] = "Pick path updated"
      redirect_to @pick_paths
    else
      render 'edit'
    end
  end

  def destroy
    PickPath.find(params[:id]).destroy
    flash[:success] = "Pick path removed"
    redirect_to pick_paths_path
  end

  def index
    @pick_paths = PickPath.search(params[:search], params[:page])
  end
  

  private

  def pick_paths_params
    params.require(:pick_path).permit(:bin_name, :pick_order)
  end

end