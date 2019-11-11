Rails.application.routes.draw do
  root "pages#home"

  get "/signin", to: "sessions#new"
  post "/signin", to: "sessions#create"
  post "/signup", to: "users#create"
  get "/signup", to: "users#new"
  delete "/logout", to: "sessions#delete"
  post "/comments/:id", to: "comments#create"
  delete "/comments/:id", to: "comments#destroy"
  get "/bookings", to: "bookings#index"
  post "/likes/:id", to: "likes#create"
  delete "/likes/:id", to: "likes#destroy"

  namespace :admin do
    root "pages#home"

    get "tickets", to: "bookings#ticket"
    resources :tours
    resources :categories, except: [:show, :new]
    resources :reviews
    resources :users, except: :edit
    resources :bookings, only: %i(index) do
      member do
        patch "/approve", to: "bookings#approve", as: "approve"
      end
    end
  end

  resources :tours, only: %i(index show) do
    resources :ratings, only: %i(create)
    resources :bookings, except: :index do
      member do
        patch "/cancel", to: "bookings#cancel", as: "cancel"
      end
    end
  end
  resources :users
  resources :reviews
  resources :categories, only: :show
  resources :comments, only: [:create, :destroy]
  resources :likes, only: [:create, :destroy]
end
