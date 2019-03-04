Rails.application.routes.draw do
  namespace :api, defaults: {format: 'json'} do
    namespace :v1 do
          # get 'import', to: 'passwords#import'
          post 'import', to: 'passwords#import'
          resources :passwords, :only => [:index, :show]
    end
  end



  resources :users do
    get 'import', :on => :collection
  end

  resources :uploads
  resources :passwords
  resources :users, :constraints => { :id => /.*/ }
  resources :vendors
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # get 'auth/:provider/callback', to: 'sessions#create'
  get 'login', to: 'sessions#create',  as: :create_login

  get 'auth/failure', to: redirect('/')
  get 'signout', to: 'sessions#destroy', as: 'signout'

  get '/downloads/:id', to: 'uploads#download'

  resources :sessions, only: [:create, :destroy]

  resources :uploads do
    member do

      put 'rerun'

    end
  end

  resources :vendors do
    member do

      get 'remove_logo'

    end
  end



  # root 'users#show'
  root 'login#index'
end
