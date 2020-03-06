Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'

  resources :users, only: [:show]
  resources :spaceships do
    resources :bookings, only: [:new, :create]
  end
  resources :bookings, only: [:show] do
    resources :reviews, only: [:new, :create]
  end

  get '/dashboard', to: 'pages#dashboard', as: :dashboard
  post '/bookings/:id/accept', to: 'bookings#accept', as: :accept_booking
  post '/bookings/:id/reject', to: 'bookings#reject', as: :reject_booking
  post '/bookings/:id/pending', to: 'bookings#pending', as: :pending_booking
  post '/bookings/:id/cancel', to: 'bookings#cancel', as: :cancel_booking
end
