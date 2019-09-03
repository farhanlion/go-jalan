Rails.application.routes.draw do
  get 'service_favourites/index'
  get 'service_favourites/create'
  get 'service_favourites/destroy'
  get 'provider_favourites/index'
  get 'provider_favourites/create'
  get 'provider_favourites/destroy'
  devise_for :users
  root to: 'pages#home'
  resources :providers, only: [:index, :show] do
      resources :reviews, only: [:new, :create]
  end
  resources :services, only: [:index, :show] do
    resources :reviews, only: [:new, :create]
    resources :provider_favourites, only: [:index, :create, :destroy]
  end

  resources :services, only: [:index, :show] do
	  resources :service_favourites, only: [:index, :create, :destroy]
	end
	resources :reviews, only: [:index, :edit, :update, :destroy]

end
