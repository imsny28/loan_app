Rails.application.routes.draw do

  root 'dashboard#index'
  resources :users
  resources :customers
  resources :collaterals
  resources :attribute_options
  resources :collateral_types
  resources :attachments

  namespace :api do
    namespace :v1 do
      resources :attribute_options
      resources :customers
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
