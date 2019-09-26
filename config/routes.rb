Rails.application.routes.draw do

  get 'attribute_options/index'
  get 'collaterals/index'
  root 'dashboard#index'
  resources :users
  resources :customers
  resources :collaterals
  resources :attribute_options


  namespace :api do
    namespace :v1 do
      resources :attribute_options

      resources :customers
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
