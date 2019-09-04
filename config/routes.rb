Rails.application.routes.draw do

  devise_for :users
  root to: 'pages#home'
  get "reviews/new", to: "reviews#new_no_provider", as: "new_review"

  resources :favourites, only: [:index]

  resources :providers, only: [:index, :show] do
      resources :reviews, only: [:new, :create]
      resources :favourites, only: [:create, :destroy]
  end

  resources :reviews, only: [:show] do
    resources :likes, only: [:create]
  end

	resources :reviews, only: [:index, :create, :edit, :update, :destroy]
  resources :users, only: [:show, :edit, :update, :destroy]
  resources :likes, only: [:destroy]

end
