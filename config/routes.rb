Rails.application.routes.draw do
  devise_for :users
  namespace :api do
    namespace :v1 do
      resources :users, only:[:create]
      post '/login', to: 'auth/#login'
      get '/index', to: 'users/#index'
      resources :motorcycles
      resources :reservations
    end
  end
end
