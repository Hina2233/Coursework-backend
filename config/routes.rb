Rails.application.routes.draw do
  devise_for :users
  namespace :api do
    namespace :v1 do
      resources :users, only: [:create]
      post 'users/login', to: 'users#login'
      resources :ideas do
        # Nested routes for comments within ideas
        resources :comments, only: [:index, :create, :update, :destroy]

        # Route for voting on ideas
        member do
          post :vote
        end
      end

    end
  end

  namespace :admin do
      resources :users
      resources :ideas

      root to: "users#index"
  end


  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  # Defines the root path route ("/")
  # root "posts#index"
end
