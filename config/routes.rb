Rails.application.routes.draw do
  devise_for :users
  root to: 'bbqs#index'
  # get '/bbqs', to: 'bbqs#index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  get '/bbqs/search', to: 'bbqs#search'
  resources :bbqs do
    resources :reviews, only: %i[new create]
    resources :bookings, only: %i[new create]
  end
  # Defines the root path route ("/")
  resources :bookings, except: %i[new create]
end
