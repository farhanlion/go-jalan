Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  resources :providers, only: [:index, :show] do
      resources :reviews, only: [:new, :create]
  end
  resources :services, only: [:index, :show] do
    resources :reviews, only: [:new, :create]
  end
  resources :reviews, only: [:index]
end
