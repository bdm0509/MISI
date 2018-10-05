Rails.application.routes.draw do
  root    'pages#home'
  
  get     '/signup',      to: 'users#new'
  post    '/signup',      to: 'users#create'
  get     '/login',       to: 'sessions#new'
  post    '/login',       to: 'sessions#create'
  delete  '/logout',      to: 'sessions#destroy'
  get     '/main',        to: 'pages#main'
  
  resources :users
  resources :password_resets,     only: [:new, :create, :edit, :update]
  
  resources :fee_collection_types
end
