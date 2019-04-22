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
  
  resources               :assureds
  resources               :fee_collection_types
  resources               :district_types
  resources               :collection_districts
  
  resources               :maintenance_funds do
    collection do
      get 'print'
    end
  end
  
  resources               :maintenance_orders do
    member do
      patch 'print'
    end
    collection do
      get  'update_special_characters'
    end
  end
  
  resources               :tax_certificates do
    member do
      patch 'print'
    end
    collection do
      get  'update_special_characters'
    end
  end
  
  resources :maintenance_fund_fees do
    member do
      post 'update'
    end
  end
end
