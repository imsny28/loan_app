class Api::V1::AttributeOptionsController < ApplicationController
 include Response

  def index
    @attribute_options = AttributeOption.all
    render json: { records: @attribute_options.as_json(root: false), methods: [] }

    # render json: { records: @attribute_options.as_json(root: false), methods: [], count: @attribute_options.total_count}
  end

  def new
    @attribute_options = AttributeOption.new
    @attribute_option_values = @attribute_options.attribute_option_values.build

    response_to_get({
      attribute_options: @attribute_options,
      attribute_option_values_attributes: @attribute_option_values
    })
  end

  def show
    @attribute_option = AttributeOption.includes(:attribute_option_values).find_by(id: params[:id])
    response_to_get @attribute_option
  end

  def create
    @attribute_option = AttributeOption.new(attribute_option_params)

    if @attribute_option.save
      success_response_to_post @attribute_option
    else
      failure_response_to_post @attribute_option.errors
    end
  end

  private

  def attribute_option_params
    params.require(:attribute_option).permit(
      :name,
      :display_name,
      attribute_option_values_attributes: [
        :id, :name, :display_name, :_distory
      ]
    )
  end

end
