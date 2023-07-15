Rails.application.routes.draw do
  devise_for :users
  resources :users, only: [:index, :show] do
    resources :posts, only: [:index, :new, :create, :show] do
      resources :comments, only: [:create, :new]
      resources :likes, only: [:create]
    end
  end
  resources :posts, only: [:create]
  root "users#index"
end
