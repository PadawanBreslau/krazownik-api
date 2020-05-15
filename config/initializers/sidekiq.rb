Sidekiq.default_worker_options = { retry: 3, backtrace: 20 }
Sidekiq.configure_server do |config|
  config.log_formatter = Sidekiq::Logger::Formatters::WithoutTimestamp.new if Rails.env.production?
end
