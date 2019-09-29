class CustomersController < ApplicationController
  include Response

  def index
    session[:per_page_value] ||= 15
    session[:per_page_value] = params[:per_page].to_i if params[:per_page].present?
    @per_page = session[:per_page_value]

    @customers = Customer.where(archived: false)
    @customers = @customers.page(params[:page]).per(@per_page)

    if CUSTOM_FIELDS["customers"].present?
      @fields = CUSTOM_FIELDS["customers"]
    else
      @fields = Customer.new.attributes.keys.sort
    end
  end

  def new
    @customer = Customer.new
    @customer.build_account

    # @attribute_options = AttributeOption.where(archived: false).includes(:attribute_option_values)
  end

  def create
    @customer = Customer.new(customer_params)
    if @customer.save
      success_response_to_post @customer, customers_path, "Customer created successfully."
    else
      failure_response_to_post @customer.errors, new_attribute_option_path
    end
  end

  def edit
    @customer = Customer.find_by(id: params[:id])
  end

  def show
    @customer = Customer.find_by(id: params[:id])
    response_to_get @customer
  end

  def update
    @customer = Customer.find_by(id: params[:id])
    @customer.assign_attributes(customer_params)
    debugger
    if @customer.save
      success_response_to_patch customers_path, "Customer updated successfully."
    else
      failure_response_to_post @customer.errors, :edit
    end
  end

  def destroy
    @customer = Customer.find_by(id: params[:id])
    if params[:archive]
      if @customer.archived
        @customer.archived = false
        msg = "#{@customer.display_name} unarchived successfully."
      else
        @customer.archived = true
        msg = "#{@customer.display_name} archived successfully."
      end
      @customer.save
    else
      msg = "#{@customer.display_name} deleted successfully."
      @customer.destroy
    end
    success_response_to_delete customers_path, msg
  end

  private

  def customer_params
    params.require(:customer).permit(
       :first_name, :last_name, :email, :phone,
       :address, :apartment, :state, :city, :zip_code, :ssn,
       account_attributes: [:rountine_number, :account_number]
    )
  end
end
