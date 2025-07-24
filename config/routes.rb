Rails.application.routes.draw do
  root "sessions#new"

  resources :events, only: [ :create, :update, :destroy ]
  resources :sessions, only: [ :new, :create, :destroy ]
  resources :users, only: [ :new, :create, :update, :destroy ]
  resources :finances, only: [ :index ]
  resources :hub, only: [ :index ]

  patch "/users/:id/promote", to: "users#promote", as: "promote_user"
  patch "/users/:id/demote", to: "users#demote", as: "demote_user"
  post "/finances/add_payment", to: "finances#add_payment", as: "add_payment_finances"
  post "/finances/deduct_payment", to: "finances#deduct_payment", as: "deduct_payment_finances"
  get "/login", to: "sessions#new", as: "login"
  post "/login", to: "sessions#create"
  get "/hub", to: "hub#index", as: "hub"
  get "/signup", to: "users#new", as: "signup"
  post "/signup", to: "users#create"
  get "/finances", to: "finances#index", as: :club_finances
  get "up" => "rails/health#show", as: :rails_health_check
  delete "/logout", to: "sessions#destroy", as: "logout"
end
