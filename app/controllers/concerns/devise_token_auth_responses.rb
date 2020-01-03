module DeviseTokenAuthResponses
  extend ActiveSupport::Concern
  include JsonApiResponses

  protected

  def render_devise_error(**keywords)
    render_error(**keywords)
  end

  def render_devise_success(status:, **keywords)
    render_success(status: status, **keywords)
  end
end
