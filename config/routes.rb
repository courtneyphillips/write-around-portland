Rails.application.routes.draw do
  resources :donations

  get '/publication', to: 'pages#publication'
end
