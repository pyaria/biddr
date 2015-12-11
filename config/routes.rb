Rails.application.routes.draw do
  root "auctions#index"
  resources :auctions, only: [:new, :create, :show]
  resources :sessions, only: [:new, :create, :destroy]
  resources :users, only: [:new, :create, :show]
  resources :auctions, only: [] do
    resources :bids, only: [:new, :create]
  end
end
