Rails.application.routes.draw do

  resources :viajes

  devise_for :users, :controllers => { registrations: 'registrations' }

  resources :users

#  resources :viajes
#  devise_for :users, :path => 'u', :controllers => { registrations: 'registrations' }
#  resources :users, path: 'balance' do get :balance end
#  get "users/balance", to: "users#balance", as: "balance"

  root "application#index"

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
