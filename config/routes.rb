Rails.application.routes.draw do
  resources :provider_favourites, only: [:create, :destroy, :index]
  devise_for :users
  root to: 'pages#home'
  resources :providers, only: [:index, :show] do
      resources :reviews, only: [:new, :create]
  end

  resources :reviews, only: [:show] do
    resources :review_likes, only: [:create]
  end

	resources :reviews, only: [:index, :edit, :update, :destroy]
  resources :users, only: [:show, :edit, :update, :destroy]
  resources :review_likes, only: [:destroy]

end
