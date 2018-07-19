Rails.application.routes.draw do
  root 'pages#home'	
  get 	 '/signup',	 to: 'users#new' 
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  get "/auth/:provider/callback", to: "sessions#create_from_omniauth"
  
  resources :users, except: [:new]
  resources :participants, only: [:create, :destroy, :index]
  resources :activities do 
    member do 
      put 'like', to: 'activities#vote' 
    end 
  end 
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
