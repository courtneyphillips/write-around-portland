Rails.application.routes.draw do

  devise_for :users

  root to: "pages#index"

  resources :donations
  resources :publications
  resources :orders

<<<<<<< HEAD
  get '/writers', to: 'pages#writers'
=======
  patch "/update_cart", to: "orders#update_cart"
  get '/index', to: 'pages#index'
  get '/writers', to: 'pages#writers'


>>>>>>> b17ab0ce60687975ef01a322865a28bf9c1882ca
end
