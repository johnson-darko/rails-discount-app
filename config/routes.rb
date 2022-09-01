Rails.application.routes.draw do
  resources :line_items
  resources :wishes

  devise_for :users
  root to: "pages#index"

  resources :stores, only: %i[index new create destroy edit update]

  resources :stores, only: %i[show] do
    resources :products
    resources :reviews, only: %i[index new create destroy]
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
