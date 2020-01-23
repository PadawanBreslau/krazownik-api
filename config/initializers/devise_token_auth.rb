# frozen_string_literal: true

DeviseTokenAuth.setup do |config|
  config.token_cost = Rails.env.test? ? 4 : 10
  config.change_headers_on_each_request = false
end
