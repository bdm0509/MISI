<<<<<<< HEAD
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
  resources               :maintenance_funds
  resources               :maintenance_orders
=======
Misi::Application.routes.draw do
  devise_for :admins
  devise_for :users

  resources :assureds, :fee_collection_types
  resources :users do
    member do
      get  'edit_password'
      put 'update_password'
    end
  end
  
  resources :maintenance_orders do
    member do
      get 'print'
    end
    collection do
      get  'update_special_characters'
    end
  end
  
  resources :maintenance_funds do
    collection do
      post 'datatable'
      get  'print'
      get  'update_special_characters'
    end
  end
  
  resources :maintenance_funds
>>>>>>> 528a84ac36f9ee8ae5ac92ad60e3b15c99db9827
  
  resources :maintenance_fund_fees do
    member do
      post 'update'
    end
  end
<<<<<<< HEAD
=======
  
  get "home/index"
  
  match '/admin',              :to => 'pages#admin'
  match '/home',               :to => 'pages#home'
  match '/message',            :to => 'pages#message'
  match '/home_page/show',     :to => 'home_page_text#show'
  match '/home_page/update',   :to => 'home_page_text#update'
  
  root :to => 'pages#home'
>>>>>>> 528a84ac36f9ee8ae5ac92ad60e3b15c99db9827
end
