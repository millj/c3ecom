class DirectBinContentsController < ApplicationController


  def new
  end

  def index
 #   @direct_bin_contents = DirectBinContent.paginate(page: params[:page])
    @direct_bin_contents = DirectBinContent.search(params[:search], params[:page])
  end

  private

    def direct_bin_contents_params
      params.require(:direct_bin_contents).permit(:bin_code, :item_code)
    end
end
