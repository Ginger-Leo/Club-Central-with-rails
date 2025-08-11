# frozen_string_literal: true

Rails.application.routes.draw do
  scope '(:locale)', locale: /en|fi/ do
    root 'hub#index'

    resource :session, only: %i[new create destroy], path_names: { new: 'login', destroy: 'logout' }
    resources :events, only: %i[create update destroy edit show]
    resources :users, only: %i[new create update destroy] do
      member do
        patch :promote
        patch :demote
      end
    end
    resources :finances, only: [:index], as: :club_finances do
      collection do
        post :add_payment
        post :deduct_payment
      end
    end
    get '/signup', to: 'users#new', as: 'signup'
    get '/login', to: 'sessions#new', as: 'login'
    post '/login', to: 'sessions#create'
    get '/hub', to: 'hub#index', as: 'hub'
    delete '/logout', to: 'sessions#destroy', as: 'logout'
  end
  get 'up' => 'rails/health#show', as: :rails_health_check
end
