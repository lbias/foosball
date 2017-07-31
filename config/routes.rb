Rails.application.routes.draw do
  root 'users#index'

  resources :users

  resources :matches, except: [:edit, :update]
end
