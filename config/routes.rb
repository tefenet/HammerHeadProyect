Rails.application.routes.draw do


  resources :requests do
    member do
      put :change
    end
  end
  get 'cards/new'

  get 'comments/preguntasViaje'
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

  get '/user/:id/requests', to: 'users#requests', as: 'solicitudes'
  get '/user/:id/pasajeSolicitud', to: 'users#pasajeSolicitud', as: 'solicitud_pasajero'
  root "application#index"
  get "search/balance" => 'search#balance'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
