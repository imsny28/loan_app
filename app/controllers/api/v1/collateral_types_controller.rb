class Api::V1::CollateralTypesController < ApplicationController
  # include Response

  def index
    session[:per_page_value] ||= 15
    session[:per_page_value] = params[:per_page].to_i if params[:per_page].present?
    @per_page = session[:per_page_value]

    @collateral_types = CollateralType.where(archived: false)
    @collateral_types = @collateral_types.page(params[:page]).per(@per_page)

		render json: { records: @collateral_types.as_json(root: false) }
    # if CUSTOM_FIELDS["collateral_types"].present?
    #   @fields = CUSTOM_FIELDS["collateral_types"]
    # else
    #   @fields = CollateralType.new.attributes.keys.sort
    # end
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

	def collaterals_with_attributes
		@collateral_type = CollateralType.find(params[:id])
		collaterals = @collateral_type.collaterals
		attributes = @collateral_type.attribute_options
		render json: {
			records: collaterals.as_json( only: [:id, :display_name]),
			attribute_options: attributes.as_json(
				only: [:id, :display_name, :name],
				include: {
					attribute_option_values: {
						only: [:id, :display_name]
					}
				}
			)
		}
	end


  def collateral_type_params
    params.require(:collateral_type).permit(
      :name, :display_name, collateral_ids: []
    )
  end
end
