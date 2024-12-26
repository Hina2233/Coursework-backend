Rails.application.routes.draw do
  devise_for :users

  # API routes
  namespace :api do
    namespace :v1 do
      resources :users, only: [:create]
      post 'users/login', to: 'users#login'
      resources :ideas do
        resources :comments, only: [:index, :create, :update, :destroy]
        member do
          post :vote
        end
      end
    end
  end

  # Admin routes
  namespace :admin do
    resources :users
    resources :ideas
    root to: "users#index" # Admin root route
  end

  # Main root route
  root to: "users#index" # Root for the main application

  # Health check
  get "up" => "rails/health#show", as: :rails_health_check

  # Dynamic PWA files
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
end
