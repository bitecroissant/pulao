Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :event_dates
      resources :validation_codes, only: [:create]
      resource :session, only: [:create, :destroy]
      resource :me, only: [:show]
    end
  end
end
