Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  #SPACESHIPS
  resources :spaceships do
    resources :bookings, only: [:new, :create]
    resources :reviews, only: [:new, :create]
  end
  
  resources :bookings, only: [:show]
  # get '/spaceships', to: 'spaceships#index', as: :spaceships
  # get '/spaceships/:id', to: 'spaceships#show', as: :spaceship
  # get '/spaceships/:id/new', to: 'spaceships#new', as: :new_spaceship
  # post '/spaceships', to: 'spaceships#create'
  # get 'spaceships/:id/edit', to:
  get '/dashboard', to: 'pages#dashboard', as: :dashboard
end
