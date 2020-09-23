Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :users, only: [:create]
      resources :forecast, only: [:index]
      resources :background, only: [:index]
      resources :roadtrip, only: [:create]
      post '/login', to: 'sessions#create'
    end
  end 
end
