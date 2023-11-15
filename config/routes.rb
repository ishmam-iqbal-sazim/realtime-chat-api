Rails.application.routes.draw do
  use_doorkeeper do
    skip_controllers :authorizations, :applications, :authorized_applications
  end
  namespace :api do
    namespace :v1 do
      get "users", to: "users#index"
      post "users", to: "users#create"

      post "login", to: "sessions#new"

      get "messages", to: "direct_messages#index"
      post "messages", to: "direct_messages#new"

      mount ActionCable.server => '/cable'
    end
  end
end