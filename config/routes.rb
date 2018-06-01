Rails.application.routes.draw do
  root "application#index"
  resources :viajes
  devise_for :users, :path => 'u', :controllers => { registrations: 'registrations' }
  resources :users, path: 'balance' do get :balance end
  get "users/balance", to: "users#balance", as: "balance"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
