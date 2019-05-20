Rails.application.routes.draw do
  root "static_pages#home"

  get "/signup", to: "users#new"
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"
  resources :users
  resources :account_activations, only: :edit
  resources :products, only: %i(index show) do
    resources :comments
  end
  resources :carts, only: [:index, :show, :update]
  resources :order_items, only: %i(create update destroy)
  resources :comments
  resources :order_items do
    get "decrease", on: :member
    get "increase", on: :member
  end
  resources :checkouts, onlyl: :index
  resources :history_orders
end
