Rails.application.routes.draw do

  get 'collateral_types/index'
  get 'collateral_types/edit'
  get 'collateral_types/new'
  get 'attribute_options/index'
  get 'collaterals/index'
  root 'dashboard#index'
  resources :users
  resources :customers
  resources :collaterals
  resources :attribute_options
  resources :collateral_types


  namespace :api do
    namespace :v1 do
      resources :attribute_options

      resources :customers
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
