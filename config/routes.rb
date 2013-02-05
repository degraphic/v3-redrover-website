V3RedroverWebsite::Application.routes.draw do
  # 
  # devise_for :users
  # 
  # resources :events, :only => [:root, :show]
  # 
  # resources :users do
  #   collection do
  #     get :login
  #     get :oauth_callback
  #   end
  # end
  # 
  resources :styles, :only => [:index]
  
  root :to => 'main#index'
  match '/calendar/export' =>"calendar#index"
  match '/*path' => 'main#index'
end
