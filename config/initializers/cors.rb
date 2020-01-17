CORS_ORIGINS = Rails.env.production? ? ENV['CORS_ORIGINS'].to_s.split(', ') : '*'

Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins CORS_ORIGINS
    resource '*',
      headers: :any,
      expose: %w(Access-Token Client Expiry Token-Type Uid User-Role),
      methods: %i(get post put patch delete options head)
  end
end
