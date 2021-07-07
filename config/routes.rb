Rails.application.routes.draw do
  namespace :v1 do
    namespace :auth do
      resources :registration, only: :create
      resource :sessions, only: [:create, :destroy]

      namespace :passwords do
        resources :reset, only: :create
      end
    end
  end
end
