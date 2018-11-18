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
  
  resources :maintenance_fund_fees do
    member do
      post 'update'
    end
  end
  
  get "home/index"
  
  match '/admin',              :to => 'pages#admin'
  match '/home',               :to => 'pages#home'
  match '/message',            :to => 'pages#message'
  match '/home_page/show',     :to => 'home_page_text#show'
  match '/home_page/update',   :to => 'home_page_text#update'
  
  root :to => 'pages#home'
end
