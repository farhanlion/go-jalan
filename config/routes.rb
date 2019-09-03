Rails.application.routes.draw do

  devise_for :users
  root to: 'pages#home'

  resources :provider_favourites, only: [:index]

  resources :providers, only: [:index, :show] do
      resources :reviews, only: [:new, :create]
      resources :provider_favourites, only: [:create, :destroy]
  end

  resources :reviews, only: [:show] do
    resources :review_likes, only: [:create]
  end

	resources :reviews, only: [:index, :edit, :update, :destroy]
  resources :users, only: [:show, :edit, :update, :destroy]
  resources :review_likes, only: [:destroy]

end
