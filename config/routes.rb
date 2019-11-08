Rails.application.routes.draw do
  root "pages#home"

  get "/signin", to: "sessions#new"
  post "/signin", to: "sessions#create"
  post "/signup", to: "users#create"
  get "/signup", to: "users#new"
  delete "/logout", to: "sessions#delete"
  post "/comments/:id", to: "comments#create"
  delete "/comments/:id", to: "comments#destroy"
  get "/search", to: "tours#search"
  post "/search", to: "tours#search"
  namespace :admin do
    root "pages#home"
    resources :tours
  end

  resources :tours, only: %i(index show)
  resources :users
  resources :reviews
  resources :categories, only: :show
  resources :comments, only: [:create, :destroy]
end
