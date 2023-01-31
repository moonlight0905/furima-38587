Rails.application.routes.draw do
 devise_for :users
 root to: 'items#index'
 resources :items do
  resources :purchases, only: :index do
    resources :destination
  end 
 end
end
