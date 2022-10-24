Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  namespace :api do
    namespace :v1 do
      resources :users, only:[:create]
      post '/create', to: 'users#create'
      get '/login', to: 'users#login'
      resources :motorcycles
      resources :reservations
    end
  end
end
