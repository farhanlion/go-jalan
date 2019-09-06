Rails.application.routes.draw do

  devise_for :users
  root to: 'pages#home'
  get "reviews/new", to: "reviews#new_no_provider", as: "new_review"
  get "nearby", to: "pages#nearby", as: "nearby"

  resources :providers, only: [:index, :show] do
      resources :reviews, only: [:new, :create]
      resources :favourites, only: [:create]
  end

  resources :favourites, only: [:index, :destroy]

  resources :reviews, only: [:show] do
    resources :likes, only: [:create]
  end

	resources :reviews, only: [:index, :create, :edit, :update, :destroy, :show]
  resources :users, only: [:show, :edit, :update, :destroy]
  resources :likes, only: [:destroy]

  resources :categories, only: [:show]

  get "/results", to: "pages#results", as: :results
  get "/results_tags", to: "pages#results_tags", as: :results_tags
  get "/results_location", to: "pages#results_location", as: :results_location
end
