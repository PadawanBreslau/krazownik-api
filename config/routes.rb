# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      post 'auth/password_reset' => 'users#reset_password'
      post 'auth/password' => 'users#update_password'
      post 'auth/sign_up' => 'users#sign_up'

      mount_devise_token_auth_for 'User', at: 'auth', controllers: {
        sessions: 'api/v1/sessions',
        passwords: 'api/v1/passwords'
      }

      get 'panel' => 'users#panel'

      resources :users, only: [:update]
      resources :events, only: [:index]
      resources :challenges, only: [:show, :index] do
        collection do
          post :draw
        end

        member do
          post :toggle
        end
      end
      resources :riddles, only: [:show, :index]
      resources :teams, only: [:show, :index]
      resources :files, only: [:index]
      resources :bonus_points, only: [:show, :index] do
        member do
          post :toggle
        end
      end
      resources :participations, only: [:show, :index, :create]
    end
  end
end
