Rails.application.routes.draw do

  devise_for :users, :controllers => {:registrations => "registrations",
      omniauth_callbacks: "users/omniauth_callbacks"}

  root "pages#home"

  post "/comments/:id", to: "comments#create"
  delete "/comments/:id", to: "comments#destroy"
  get "/search", to: "tours#search"
  post "/search", to: "tours#search"
  post "/likes/:id", to: "likes#create"
  delete "/likes/:id", to: "likes#destroy"
  namespace :admin do
    root "pages#home"
    resources :tours
    resources :categories, except: [:show, :new]
    resources :reviews
    resources :users, except: :edit
  end

  resources :tours, only: %i(index show)
  resources :reviews
  resources :categories, only: :show
  resources :comments, only: [:create, :destroy]
  resources :likes, only: [:create, :destroy]
  resources :users, only: :show
end
