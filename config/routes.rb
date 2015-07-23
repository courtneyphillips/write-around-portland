Rails.application.routes.draw do
  resources :donations

  get '/writers', to: 'pages#writers'
end
