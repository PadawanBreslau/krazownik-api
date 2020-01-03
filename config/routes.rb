# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :events, only: [:show]
      resources :challenges, only: [:show, :index]
    end
  end
end
