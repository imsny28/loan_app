class AttributeOptionsController < ApplicationController
  def index
    @attribute_options = AttributeOption.all
  end

  def new
    @attribute_options = AttributeOption.new
    @attribute_option_values = @attribute_options.attribute_option_values.build
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
