Rails.application.routes.draw do
  get "/health", to: "health#index"

  namespace :auth do
    post :register
    post :login
    post :refresh
    delete :logout
  end

  get "/me", to: "users#me"
end
