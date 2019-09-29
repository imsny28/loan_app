class AttributeOptionsController < ApplicationController
  include Response

  def index
    @attribute_options = AttributeOption
    # if params[:query].present? && params[:field].present?
    #   @attribute_options = @attribute_options.where("LOWER(#{params[:field]}::VARCHAR) like ?", '%'+params[:query].to_s.downcase+'%')
    # end
    #
    # if params[:char].present?
    #   @attribute_options = @attribute_options.where("LOWER(first_name) like ? OR LOWER(first_name) like ?", params[:char].to_s.downcase+'%', params[:char].to_s.downcase+'%')
    # end
    session[:per_page_value] ||= 15
    session[:per_page_value] = params[:per_page].to_i if params[:per_page].present?
    @per_page = session[:per_page_value]

    @attribute_options = AttributeOption.where(archived: false)
    @attribute_options = @attribute_options.page(params[:page]).per(@per_page)
    
    if CUSTOM_FIELDS["attribute_options"].present?
      @fields = CUSTOM_FIELDS["attribute_options"]
    else
      @fields = AttributeOption.new.attributes.keys.sort
    end
  end

  def new
    @attribute_option = AttributeOption.new
    @attribute_option.attribute_option_values.build
  end

  def show
    @attribute_option = AttributeOption.includes(:attribute_option_values).find_by(id: params[:id])
    response_to_get @attribute_option
  end

  def create
    @attribute_option = AttributeOption.new(attribute_option_params)
    if @attribute_option.save
      success_response_to_post @attribute_option, attribute_options_path, "Attribute Option created successfully."
    else
      failure_response_to_post @attribute_option.errors, new_attribute_option_path
    end
  end

  def edit
    @attribute_option = AttributeOption.find_by(id: params[:id])
  end

  def update
    @attribute_option = AttributeOption.find_by(id: params[:id])
    @attribute_option.assign_attributes(attribute_option_params)
    if @attribute_option.save
      success_response_to_patch attribute_options_path, "Attribute Option updated successfully."
    else
      failure_response_to_post @attribute_option.errors, :edit
    end
  end

  def destroy
    @attribute_option = AttributeOption.find_by(id: params[:id])
    if params[:archive]
      if @attribute_option.archived
        @attribute_option.archived = false
        msg = "#{@attribute_option.display_name} unarchived successfully."
      else
        @attribute_option.archived = true
        msg = "#{@attribute_option.display_name} archived successfully."
      end
      @attribute_option.save
    else
      msg = "#{@attribute_option.display_name} deleted successfully."
      @attribute_option.destroy
    end
    success_response_to_delete attribute_options_path, msg
  end

  private
  def attribute_option_params
    params.require(:attribute_option).permit(:name, :display_name, attribute_option_values_attributes:[:id, :name, :display_name, :archived])
  end
end
