ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../config/environment', __dir__)
Dir[Rails.root.join('spec', 'support', '**', '*.rb')].sort.each { |f| require f }

abort('The Rails environment is running in production mode!') if Rails.env.production?
require 'rspec/rails'

ActiveRecord::Migration.maintain_test_schema!

ActiveJob::Base.queue_adapter = :test

RSpec.configure do |config|
  config.order = :random

  config.include FactoryBot::Syntax::Methods
  config.include ActiveSupport::Testing::TimeHelpers
  #  config.include AuthenticationHelper

  config.use_transactional_fixtures = true
  config.infer_spec_type_from_file_location!
  config.filter_rails_from_backtrace!

  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups
end

def auth_headers(user = nil)
  user ||= create(:user)
  auth_tokens = user.create_new_auth_token
  json_api_headers.merge(auth_tokens)
end

def json_api_headers
  {
    'Accept' => 'application/vnd.api+json',
    'Content-Type' => 'application/vnd.api+json'
  }
end

def basic_auth_headers
  credentials = ActionController::HttpAuthentication::Basic.encode_credentials(
    ENV['PIPEDRIVE_WEBHOOKS_USER'], ENV['PIPEDRIVE_WEBHOOKS_PASSWORD']
  )
  {
    'Accept' => 'application/json',
    'Content-Type' => 'application/json',
    'HTTP_AUTHORIZATION' => credentials
  }
end
