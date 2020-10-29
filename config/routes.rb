Rails.application.routes.draw do
  devise_for :users
  root to: "recipes#index"
  resources :recipes
  resources :users, only: [:show, :edit, :update]
end
