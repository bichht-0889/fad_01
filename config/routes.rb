Rails.application.routes.draw do
  root "static_pages#home"

  resources :users
  resources :account_activations, only: :edit
end
