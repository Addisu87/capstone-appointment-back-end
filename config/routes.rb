Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get 'reservations/index'
      get 'reservations/new'
      get 'reservations/create'
      get 'reservations/edit'
      get 'reservations/show'
      get 'reservations/update'
      get 'reservations/destroy'
      get 'motorcycles/index'
      get 'motorcycles/new'
      get 'motorcycles/create'
      get 'motorcycles/edit'
      get 'motorcycles/show'
      get 'motorcycles/update'
      get 'motorcycles/destroy'
      get 'sessions/create'
      get 'registrations/new'
      get 'registrations/create'
    end
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
