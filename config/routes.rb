Rails.application.routes.draw do
  get 'login', to: 'login#index'


  resources :users do
    get 'import', :on => :collection
  end
  
  resources :uploads
  resources :passwords
  resources :users
  resources :vendors
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get 'auth/:provider/callback', to: 'sessions#create'
  get 'auth/failure', to: redirect('/')
  get 'signout', to: 'sessions#destroy', as: 'signout'

  resources :sessions, only: [:create, :destroy]

  resources :uploads do
    member do

      put 'rerun'

    end
  end



  # root 'users#show'
  root 'login#index'
end
