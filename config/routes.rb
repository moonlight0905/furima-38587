Rails.application.routes.draw do
  get 'users/show'
  get 'cards/new'
 devise_for :users
 root to: 'items#index'
 resources :items do
  resources :purchases, only: [:index, :create]
 end
 resources :cards, only: [:new, :create]
 resources :users, only: [:show, :update]
end
