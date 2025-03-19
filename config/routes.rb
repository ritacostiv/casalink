#config/routes.rb

Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
  resources :collections, only: [:index, :create, :show] do
    resources :properties, only: [:create, :destroy, :edit, :update]
  end

# Standalone properties routes for filtering and index
resources :properties, only: [:index] do
  resources :comments, only: [:create]
end

# Add filter options route for properties
get '/properties/filter_options', to: 'properties#filter_options'

# Search route
get '/search', to: 'search#index', as: 'search'
end
