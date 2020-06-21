# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.0'

gem 'bootsnap', '>= 1.4.2', require: false
gem 'devise_token_auth'
gem 'faker'
gem 'fast_jsonapi'
gem 'figaro'
gem 'geokit'
gem 'google-cloud-storage', '~> 1.11', require: false
gem 'gpx_manipulator', '~> 0.2'
gem 'mini_magick'
gem 'pg', '>= 0.18', '< 2.0'
gem 'puma', '~> 4.3'
gem 'pundit'
gem 'rack-cors', require: 'rack/cors'
gem 'rails', '~> 6.0.2'
gem 'rollbar'
gem 'sassc-rails'
gem 'sidekiq'
gem 'telephone_number'
gem 'time_difference'
gem 'trestle'
gem 'trestle-active_storage'
gem 'trestle-auth'

group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'pry'
  gem 'pry-byebug'
  gem 'pry-remote'
  gem 'rubocop', require: false
  gem 'rubocop-faker', require: false
  gem 'rubocop-performance', require: false
  gem 'rubocop-rails', require: false
  gem 'rubocop-rspec', require: false
end

group :test do
  gem 'factory_bot_rails'
  gem 'parallel_tests'
  gem 'rspec-rails', '~> 3.5'
  gem 'simplecov'
  gem 'timecop'
end

group :development do
  gem 'letter_opener'
  gem 'listen', '>= 3.0.5', '< 3.2'
end
