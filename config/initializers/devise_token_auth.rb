# frozen_string_literal: true

DeviseTokenAuth.setup do |config|
  config.token_cost = Rails.env.test? ? 4 : 10
  config.change_headers_on_each_request = true
  config.token_lifespan = 2.weeks
  config.batch_request_buffer_throttle = 5.seconds

  # Makes it possible to change the headers names
  config.headers_names = {:'access-token' => 'Access-Token',
                         :'client' => 'Client',
                         :'expiry' => 'Expiry',
                         :'uid' => 'Uid',
                         :'token-type' => 'Token-Type' }
end
