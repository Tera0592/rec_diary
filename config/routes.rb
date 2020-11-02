Rails.application.routes.draw do
  devise_for :users
  root to: "recipes#index"
  resources :recipes do
    collection do
      get 'search'
    end
  end
  resources :diaries
  resources :users, only: [:show, :edit, :update]
end
