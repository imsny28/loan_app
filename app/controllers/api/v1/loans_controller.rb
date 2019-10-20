class Api::V1::LoansController < ApplicationController
	include ResponseApi

  def index
		session[:per_page_value] ||= 15
    session[:per_page_value] = params[:per_page].to_i if params[:per_page].present?
    @per_page = session[:per_page_value]

    @loans = Loan.where(archived: false)
    @loans = @loans.page(params[:page]).per(@per_page)
		render json: { records: @loans.as_json(root: false) }
    if CUSTOM_FIELDS["loans"].present?
      @fields = CUSTOM_FIELDS["loans"]
    else
      @fields = Loan.new.attributes.keys.sort
    end
  end

	def new
		@loan = Loan.new
  end

	def create
		loan_params_only = loan_params.as_json.except("customer", "account_detail", "line_item")
		customer_params = loan_params["customer"].as_json
		account_params = loan_params["account_detail"].as_json
		line_item_params = loan_params["line_item"].as_json

		return failure_response_to_post( {errors: "Customer Information is not present "} ) if customer_params.has_blank?
		return failure_response_to_post( {errors: "Account Detail is not present "} ) if account_params.has_blank?
		return failure_response_to_post( {errors: "Line Items is not present "} ) if line_item_params.has_blank?

		loan = Loan.new( loan_params_only )

		customer = Customer.find_by( email: customer_params["email"] )
		unless customer
			customer = Customer.new( customer_params )
			return failure_response_to_post( customer.errors ) unless customer.save
		end

		account = Account.find_by( rountine_number: account_params["rountine_number"] )
		unless account
			account = Account.new(account_params)
			account.customer_id = customer.id
			return failure_response_to_post( customer.errors ) unless account.save
		end

		loan.customer_id = customer.id
		loan.build_line_item( line_item_params )
		if loan.save
			success_response_to_post loan
		else
			failure_response_to_post loan.errors
		end
	end

	def show
    @loan = Loan.includes(:customer, :line_item).find_by(id: params[:id])
  end

	def update
	end

  def edit
  end

	def destroy
    @loan = Loan.find_by(id: params[:id])
    if params[:archive]
      if @loan.archived
        @loan.archived = false
        msg = "Loan unarchived successfully."
      else
        @loan.archived = true
        msg = "Loan archived successfully."
      end
      @loan.save
    else
      msg = "Loan deleted successfully."
      @loan.destroy
    end

    success_response_to_delete collateral_types_path, msg
  end

	def loan_params
		params.require(:loan).permit!
		# params.require(:loan).permit(
		# 	:total_amount, :payoff,
		# 	customer: [
		# 		:id, :email, :first_name, :last_name, :phone,
		# 		:apartment, :address, :state,:city, :zip_code, :ssn
		# 	],
		# 	account_detail: [
		# 		:rountine_number, :account_number
		# 	],
		# 	line_item: [
		# 		:name, :amount, custom_field: []
		# 	]
		# )
	end
end
