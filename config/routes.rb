Rails.application.routes.draw do
  resources :provider_favourites, only: [:create, :destroy, :index]
  devise_for :users
  root to: 'pages#home'
  resources :providers, only: [:index, :show] do
      resources :reviews, only: [:new, :create]
  end
  resources :services, only: [:index, :show] do
    resources :reviews, only: [:new, :create]
  end

	resources :reviews, only: [:index, :edit, :update, :destroy]

end
