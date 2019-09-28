class CollateralsController < ApplicationController
  include Response

  def index
    @collateral = Collateral.all
  end

  def new
    @collateral = Collateral.new
  end

  def create
    @collateral = Collateral.new(collateral_params)
    if @collateral.save
      success_response_to_post @collateral, collaterals_path, "Collateral created successfully."
    else
      failure_response_to_post @collateral.errors, new_attribute_option_path
    end
  end

  def edit
    @collateral = Collateral.find_by(id: params[:id])
  end

  def show
    @collateral = Collateral.find_by(id: params[:id])
    response_to_get @collateral
  end

  def destroy
    @collateral = Collateral.find_by(id: params[:id])
    if params[:archive]
      if @collateral.archived
        @collateral.archived = false
        msg = "#{@collateral.display_name} unarchived successfully."
      else
        @collateral.archived = true
        msg = "#{@collateral.display_name} archived successfully."
      end
      @collateral.save
    else
      msg = "#{@collateral.display_name} deleted successfully."
      @collateral.destroy
    end
    success_response_to_delete collaterals_path, msg
  end

  private
  def collateral_params
    params.require(:collateral).permit(:name, :display_name, :cost_price)
  end
end
