class CollateralTypesController < ApplicationController
  include Response

  def index
    @collateral_types =  CollateralType.all
  end

  def create
    @collateral_type = CollateralType.new(collateral_type_params)
    if @collateral_type.save
      success_response_to_post @collateral_type, collateral_types_path, "Collateral Type created successfully."

    else
      failure_response_to_post @collateral_type.errors, new_collateral_type_path
    end
  end

  def edit
    @collateral_type = CollateralType.find_by(id: params[:id])
  end

  def new
    @collateral_type = CollateralType.new
    @collateral_type.collaterals.build
  end

  def update
    @collateral_type = CollateralType.find_by(id: params[:id])
    if @collateral_type.update(collateral_type_params)
      success_response_to_patch collateral_types_path, "Collateral Type updated successfully."
    else
      failure_response_to_post @collateral_type.errors, :edit
    end
  end

  def destroy
    @collateral_type = CollateralType.find_by(id: params[:id])
    if params[:archive]
      if @collateral_type.archived
        @collateral_type.archived = false
        msg = "#{@collateral_type.display_name} unarchived successfully."
      else
        @collateral_type.archived = true
        msg = "#{@collateral_type.display_name} archived successfully."
      end
      @collateral_type.save
    else
      msg = "#{@collateral_type.display_name} deleted successfully."
      @collateral_type.destroy
    end
    success_response_to_delete collateral_types_path, msg
  end

  def collateral_type_params
    params.require(:collateral_type).permit(
      :name, :display_name, collateral_ids: []
    )
  end
end
