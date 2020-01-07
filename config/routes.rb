# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      mount_devise_token_auth_for 'User', at: 'auth', controllers: {
        sessions: 'api/v1/sessions',
        passwords: 'api/v1/passwords'
      }

      resources :events, only: [:show]
      resources :challenges, only: [:show, :index]
    end
  end
end
