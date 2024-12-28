Rails.application.routes.draw do
  get "home/index"
  devise_for :users

  # API routes
  namespace :api do
    namespace :v1 do
      resources :users, only: [:create]
      post 'users/login', to: 'users#login'
      resources :ideas do
        collection do
          get 'my_ideas', to: 'ideas#my_ideas'  # Add this line for current user's ideas
        end
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
    resources :comments
    resources :votes
    resources :ideas do
      member do
        post :toggle_shortlisted
      end
    end
  end

  # Redirect to the correct page after login
  root to: 'home#index'  # Redirects to home#index by default

  # Health check
  get "up" => "rails/health#show", as: :rails_health_check

  # Dynamic PWA files
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  match '*path', to: 'home#index', via: :all
end
