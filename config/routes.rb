Rails.application.routes.draw do

  root 'dashboard#index'
  resources :users
  resources :customers
  resources :collaterals
  resources :attribute_options
  resources :collateral_types
  resources :attachments
	resources :loans

  namespace :api do
    namespace :v1 do
      resources :attribute_options
      resources :customers
			resources :collateral_types do
				get :collaterals_with_attributes, on: :collection
			end
			resources :collaterals do
				get :collateral_attributes, on: :collection
				get :calculate_collateral_value, on: :collection
			end
			resources :customers
			resources :countries do
				get :countries_with_states, on: :collection
			end
			resources :loans
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
