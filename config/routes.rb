Rails.application.routes.draw do
  root "pages#home"

  get "/signin", to: "sessions#new"
  post "/signin", to: "sessions#create"
  post "/signup", to: "users#create"
  get "/signup", to: "users#new"
  delete "/logout", to: "sessions#delete"
  get "category/:id_category", to: "categories#show"
  namespace :admin do
    root "pages#home"
  end

  resources :users
  resources :reviews
end
