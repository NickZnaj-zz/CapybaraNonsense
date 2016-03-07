Rails.application.routes.draw do
  root to:
    "sessions#new"

  resources :users, only: [:new, :create, :show, :index]
  resource :session, only: [:new, :create, :destroy]
  resources :goals, only: [:create, :destroy, :edit, :update]
end
