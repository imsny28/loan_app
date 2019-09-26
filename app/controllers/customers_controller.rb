class CustomersController < ApplicationController
  def index
    @customers = Customer.all
  end
end



# rails generate model AttributeOption name:string display_name:string

# rails generate model AttributeOptionValue name:string display_name:string attribute_option_id:integer
