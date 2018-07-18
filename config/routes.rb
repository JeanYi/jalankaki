Rails.application.routes.draw do
  root 'pages#home'	
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  get "/auth/:provider/callback", to: "sessions#create_from_omniauth"
  
  resources :users
  resources :activities
  resources :participants, only: [:create, :destroy]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
