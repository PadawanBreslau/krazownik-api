Rollbar.configure do |config|
  config.access_token = ENV['ROLLBAR_ACCESS_TOKEN']

  config.enabled = false if Rails.env.test? || Rails.env.development?

  config.environment = ENV['ROLLBAR_ENV'] || Rails.env

  config.exception_level_filters.merge!(
    'ActionController::RoutingError' => 'ignore',
    'ActionController::BadRequest' => 'ignore',
  )
end
