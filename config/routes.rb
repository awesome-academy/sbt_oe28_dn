Rails.application.routes.draw do
  mount Ckeditor::Engine => "/ckeditor"
  mount RailsAdmin::Engine => "/railsadmin", as: "rails_admin"
  root "pages#home"

  devise_for :users, controllers: {omniauth_callbacks: "users/omniauth_callbacks"}

  post "/comments/:id", to: "comments#create"
  delete "/comments/:id", to: "comments#destroy"
  get "/bookings", to: "bookings#index"
  post "/likes/:id", to: "likes#create"
  delete "/likes/:id", to: "likes#destroy"

  namespace :admin do
    root "pages#home"

    get "tickets", to: "bookings#ticket"
    get "trashes", to: "bookings#trash"
    resources :tours
    resources :categories, except: [:show, :new]
    resources :reviews
    resources :users, except: %i(edit update show) do
      member do
        patch "/admin", to: "users#admin", as: "admin"
        patch "/user", to: "users#user", as: "user"
      end
    end
    resources :bookings, only: %i(index destroy) do
      member do
        patch "/approve", to: "bookings#approve", as: "approve"
        patch "/restore", to: "bookings#restore", as: "restore"
      end
    end
  end
  resources :tours, only: %i(index show) do
    resources :ratings, only: %i(create)
    resources :bookings do
      member do
        patch "/cancel", to: "bookings#cancel", as: "cancel"
      end
    end
  end
  resources :users, only: :show
  resources :reviews
  resources :categories, only: :show
  resources :comments, only: [:create, :destroy]
  resources :likes, only: [:create, :destroy]
end
