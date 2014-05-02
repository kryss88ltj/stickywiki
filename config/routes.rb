Blocipedia::Application.routes.draw do

 resources :collaborations, :only => [:new, :destroy ]
  resources :subscriptions
  resources :plans
  resources :wikis  
  devise_for :users
 
  root :to => "welcome#index"

end
