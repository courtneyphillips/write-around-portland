Rails.application.routes.draw do
  root to: "pages#index"

  resources :donations

  get '/index', to: 'pages#index'

end
