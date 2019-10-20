class Api::V1::CollateralsController < ApplicationController
  include Response

  def index
    session[:per_page_value] ||= 15
    session[:per_page_value] = params[:per_page].to_i if params[:per_page].present?
    @per_page = session[:per_page_value]

    @collaterals = Collateral.where(archived: false)
    @collaterals = @collaterals.page(params[:page]).per(@per_page)

    if CUSTOM_FIELDS["collaterals"].present?
      @fields = CUSTOM_FIELDS["collaterals"]
    else
      @fields = Collateral.new.attributes.keys.sort
    end
  end

  def new
    @collateral = Collateral.new
    @attribute_options = AttributeOption.where(archived: false).includes(:attribute_option_values)
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

  def update
    @collateral = Collateral.find_by(id: params[:id])
    @collateral.assign_attributes(collateral_params)
    if @collateral.save
      success_response_to_patch collaterals_path, "#{@collateral.display_name} updated successfully."
    else
      failure_response_to_post @collateral.errors, :edit
    end
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

	def collateral_attributes
		@collateral = Collateral.find(params[:id])
		attribute_options = @collateral.attribute_options
		render json: { records: attribute_options.as_json(root: false) }
	end

	def calculate_collateral_value
		collateral = Collateral.find_by(
			id: params[:id],
			collateral_type_id: params[:collateral_type_id]
		)
		render json: { price: collateral.cost_price, alert: "You're qualified for loan ammount " }
	end


  private
  def collateral_params
    params.require(:collateral).permit(
      :name, :display_name, :collertal_value, :cost_price,  :collateral_type_id,
      attribute_option_ids: [], attribute_option_value_ids: []
    )
  end
end
