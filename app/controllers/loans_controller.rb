class LoansController < ApplicationController
	include  Response

  def index
		session[:per_page_value] ||= 15
    session[:per_page_value] = params[:per_page].to_i if params[:per_page].present?
    @per_page = session[:per_page_value]

    @loans = Loan.where(archived: false)
    @loans = @loans.page(params[:page]).per(@per_page)

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
		customer_params =  loan_params["customer"].as_json
		account_detail =  loan_params["account_detail"].as_json
		line_item_params =  loan_params["line_item"].as_json

		# TODO:- Remember in future API
		#return failure_response_to_post(customer.errors, new_attribute_option_path) if customer.blank

		@loan = Loan.new(loan_params_only)
		# customer = Customer.new(customer_params)
		# unless customer.save
		# 	# error
		# 	# failure_response_to_post customer.errors, new_loan_path
		# 	# return
		# end
		#
		# loan.customer_id = customer.id
		@loan.customer_id = 3
		@loan.build_line_item(line_item_params)
		if @loan.save
			success_response_to_post @loan, loans_path, "loan created successfully."
		else
			# error
		end
	end

  def show
  end

	def update

	end

  def edit
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
