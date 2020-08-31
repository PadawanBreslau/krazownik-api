# frozen_string_literal: true

require 'sidekiq/web'

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
      resources :notes, only: [:index]
      resources :challenges, only: [:show, :index] do
        collection do
          post :draw
        end

        member do
          post :toggle
        end
      end
      resources :riddles, only: [:show, :index]
      resources :results, only: [:index]
      resources :teams, only: [:show, :index]
      resources :photos, only: [:index, :show]
      resources :files, only: [:index] do
        collection do
          post :upload
        end
      end
      resources :tracks, only: [:index, :show] do
        collection do
          post :upload
        end

        member do
          get :all
        end
      end
      resources :bonus_points, only: [:show, :index] do
        member do
          post :toggle
        end
      end
      resources :participations, only: [:show, :index, :create]
      resources :gpx_points, only: [:index]
    end
  end
  mount Sidekiq::Web, at: '/sidekiq_monitor'
end
