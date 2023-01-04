require "sidekiq/web"

Rails.application.routes.draw do
  mount Rswag::Ui::Engine => "/api-docs"
  mount Rswag::Api::Engine => "/api-docs"

  devise_for :admin, class_name: AdminUser, only: %i[sessions]
  namespace :admin do
    authenticated :admin do
      mount Sidekiq::Web => "/sidekiq"
    end
    resources :users, except: [:new, :create]
    resources :advisors
    resources :investors
    resources :companies
    resources :products
    resources :cryptocurrencies
    resources :investments
    resources :people

    root to: "users#index"
  end

  namespace :api do
    namespace :v1 do
      mount_devise_token_auth_for "User", at: "auth", controllers: {
        confirmations: "api/v1/users/confirmations",
        passwords: "api/v1/users/passwords",
        registrations: "api/v1/users/registrations",
        sessions: "api/v1/users/sessions"
      }

      resources :products, only: [:index, :show]
      resources :people, only: [:update]
    end
  end
end
