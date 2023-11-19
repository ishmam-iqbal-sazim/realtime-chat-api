Rails.application.routes.draw do
  use_doorkeeper do
    skip_controllers :authorizations, :applications, :authorized_applications
  end
  namespace :api do
    namespace :v1 do
      get "users", to: "users#index"
      post "users", to: "users#create_new_user"

      post "login", to: "sessions#login_user"

      get "messages", to: "direct_messages#chat_history"
      post "messages", to: "direct_messages#new_message"

      mount ActionCable.server => '/cable'
    end
  end
end