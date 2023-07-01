Rails.application.routes.draw do
  resources :users, only: [:index, :show] do
    resources :posts, only: [:index, :new, :create, :show]
  end
  resources :posts, only: [:create]
  root "users#index"
end
