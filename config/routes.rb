Rails.application.routes.draw do
  root "auctions#index"
  resources :auctions, only: [:new, :create, :show]
  resources :sessions, only: [:new]
  resources :users, only: [:new, :create]
end
