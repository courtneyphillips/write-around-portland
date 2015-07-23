Rails.application.routes.draw do

  devise_for :users

  root to: "pages#index"

  resources :donations
  resources :publications
  resources :orders

  patch "/update_cart", to: "orders#update_cart"
  get '/index', to: 'pages#index'
  get '/writers', to: 'pages#writers'


end
