Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get "users", to: "users#index"
      post "users", to: "users#create"

      get "messages", to: "direct_messages#index"
      post "messages", to: "direct_messages#new"

      mount ActionCable.server => '/cable'
    end
  end
end
