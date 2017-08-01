Rails.application.routes.draw do
  root 'users#index'

  resources :users

  resources :matches, except: [:edit, :update] do
    resources :games, only: [:create, :destroy]
  end

  resources :statistics
end
