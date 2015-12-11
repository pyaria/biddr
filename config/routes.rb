Rails.application.routes.draw do
  resources :auctions, only: [:new, :create]
  resources :sessions, only: [:new]
end
