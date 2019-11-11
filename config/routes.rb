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
  get "/bookings", to: "bookings#index"
  patch "tours/:tour_id/bookings/:id/cancel", to: "bookings#cancel", as: "tour_bookings_cancel"

  namespace :admin do
    root "pages#home"

    patch "tours/:tour_id/bookings/:id/cancel", to: "bookings#cancel", as: "cancel"
    patch "tours/:tour_id/bookings/:id/approve", to: "bookings#approve", as: "approve"
    get "tickets", to: "bookings#ticket"
    resources :tours
    resources :bookings, only: %i(index)
  end

  resources :tours, only: %i(index show) do
    resources :ratings, only: %i(create)
    resources :bookings, except: :index
  end
  resources :users
  resources :reviews
  resources :categories, only: :show
  resources :comments, only: [:create, :destroy]
end
