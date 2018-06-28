Rails.application.routes.draw do

  resources :cars
  resources :viajes

  devise_for :users, :controllers => { registrations: 'registrations' }

  resources :users

  get "/balance", to: "application#balance", as: "balance"

  get '/user/:id/viajes', to: 'users#viajes', as: 'misviajes'

  root "application#index"

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
