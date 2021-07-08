Rails.application.routes.draw do
  namespace :v1 do
    namespace :auth do
      resources :registration, only: :create
      resource :sessions, only: [:create, :destroy]
    end

    namespace :dashboard do
      resources :home, only: :index
      resources :posts, only: [:show, :create, :update, :destroy]
    end
  end
end
