module UserHeaders
  extend ActiveSupport::Concern

  included do
    after_action :add_headers
  end

  protected

  def add_headers
    response.headers['User-Role'] = 'user' if current_api_v1_user
  end
end
