Blocipedia::Application.routes.draw do

  # get "charges/create"

  devise_for :users
  # devise_for :users do
  #   get 'signup_new', :to => 'devise/registrations#new'
  # end

  # get 'signup_new', :to => 'devise/registrations#new'

  devise_scope :user do 
    get "/signup_new" => "devise/registrations#new" 
  end
  
  resources :charges, only: [:new, :create]
  resources :wikis

  get "welcome/index"
  root to: 'welcome#index'

end
