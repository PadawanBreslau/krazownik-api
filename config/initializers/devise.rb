Devise.setup do |config|
  config.mailer_sender = ENV['DEVISE_MAILER_SENDER']
  config.secret_key =    ENV['SECRET_KEY_BASE']
  config.stretches = Rails.env.test? ? 1 : 11
end
