Rails.application.routes.draw do
  resources :favorites, only: [:create, :destroy]
  resources :crops, only: [:create]
  resources :todos, only: [:create, :destroy, :update, :show]
  resources :stages, only: [:create]
  resources :beds, only: [:update]
  resources :fields, only: [:create, :destroy, :show]

  namespace :api do
    namespace :v1 do
      resources :users, only: [:create, :show]
      post '/login', to: 'auth#create'
      get '/profile', to: 'users#profile'
    end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end