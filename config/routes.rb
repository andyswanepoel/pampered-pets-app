Rails.application.routes.draw do
  resources :bookings do
      patch "/accept", to: "bookings#accept"
      patch "/decline", to: "bookings#decline"
      patch "/cancel", to: "bookings#cancel"
  end

  resources :pets

  # Dashboard
  get "/dashboard", to: "dashboard#index", as: :dashboard

  # Users
  get "/signup", to: "users#new", as: :signup
  resources :users, only: [ :create ]

  # Verification
  get "/verify-account", to: "verification#verify_account"
  get "/send-verification", to: "verification#index"
  post "/send-verification", to: "verification#send_verification_email"

  # Session
  resource :session, only: [ :create ]
  get "/login", to: "sessions#new", as: :login
  get "/logout", to: "sessions#destroy", as: :logout

  # Password
  resources :passwords, param: :token
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  root "home#index"
end
