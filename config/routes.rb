Rails.application.routes.draw do
  use_doorkeeper do
    skip_controllers :authorizations, :applications, :authorized_applications
  end
  namespace :api do
    namespace :v1 do
      get "stream", to: "server_events#index"

      get "users", to: "users#get_all_users"
      post "users", to: "users#create_new_user"

      post "login", to: "sessions#login_user"
      post "revoke_token", to: "sessions#revoke_token"

      get "messages", to: "direct_messages#chat_history"
      post "messages", to: "direct_messages#new_message"

      mount ActionCable.server => '/cable_socket'
    end
  end
end