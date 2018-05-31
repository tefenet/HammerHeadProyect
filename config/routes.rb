Rails.application.routes.draw do
	
  resources :viajes

  devise_for :users, :controllers => { registrations: 'registrations' }

  resources :users

  root "application#index"

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
