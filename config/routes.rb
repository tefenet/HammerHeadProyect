Rails.application.routes.draw do


  get 'cards/new'
  resources :cards
  resources :cars
  resources :viajes  do
    member do
      put :add_Pasajero
    end
  end
  resources :comments

  devise_for :users, :controllers => { registrations: 'registrations' }

  resources :users

  get "/balance", to: "application#balance", as: "balance"

  get '/user/:id/viajes', to: 'users#viajes', as: 'misviajes'

  get '/user/:id/cars', to: 'users#cars', as: 'misautos'

  root "application#index"
  get "search/balance" => 'search#balance'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
