module JsonApiHeaders
  extend ActiveSupport::Concern

  included do
    before_action :set_headers, :check_headers
  end

  protected

  def set_headers
    response.headers['Content-Type'] = 'application/vnd.api+json'
  end

  def check_headers
    if request.headers['Content-Type'] != 'application/vnd.api+json'
      render_error title: 'Unsupported Media Type', status: :unsupported_media_type
    elsif request.headers['Accept'] != 'application/vnd.api+json'
      render_error title: 'Not Acceptable', status: :not_acceptable
    end
  end
end
