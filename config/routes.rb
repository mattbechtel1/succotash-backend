Rails.application.routes.draw do
  resources :stages, only: [:create, :index]
  resources :beds, only: [:update]
  resources :fields
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
