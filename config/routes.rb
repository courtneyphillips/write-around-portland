Rails.application.routes.draw do
  root to: "pages#index"

  resources :donations

  get '/index', to: 'pages#index'


  get '/publication', to: 'pages#publication'

end
