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

      resources :users, only: [:show, :update] do
        member do
          post :avatar
        end
      end
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
      resources :results, only: [:index]
      resources :teams, only: [:show, :index] do
        resources :team_tasks do
          member do
            post :photo
          end
        end

        collection do
          get :panel
        end
      end
      resources :team_task_photos, only: [:show, :update, :destroy]
      resources :photos, only: [:index, :show]
      resources :files, only: [:index] do
        collection do
          post :upload
        end
      end
      resources :media, only: [:index] do
        collection do
          post :upload
        end
      end
      resources :tracks, only: [:index, :show, :update, :destroy] do
        collection do
          get :index_all
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
      resources :participations, only: [:show, :index, :create] do
        collection do
          get :current
        end
      end
      resources :gpx_points, only: [:index]

      namespace :crypto do
        resources :participations, only: [:show, :index] do
          collection do
            get :own
          end
        end
        resources :riddle_solutions, only: [:index, :create]
      end
    end
  end
  mount Sidekiq::Web, at: '/sidekiq_monitor'
end
