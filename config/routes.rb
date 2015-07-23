Rails.application.routes.draw do
  devise_for :users
  resources :donations
  resources :publications
  resources :carts
  resources :orders

  patch "/update_cart", to: "orders#update_cart"

  get '/publication', to: 'pages#publication'
end
