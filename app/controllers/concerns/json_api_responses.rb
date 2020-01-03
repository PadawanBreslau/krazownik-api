module JsonApiResponses
  extend ActiveSupport::Concern

  protected

  def render_error(status:, title:, detail: nil)
    response = {
      errors: [
        {
          status: Rack::Utils.status_code(status).to_s,
          title: title
        }
      ]
    }
    response[:errors][0][:detail] = detail if detail
    render json: response, status: status
  end

  def render_success(status: :ok, data: {}, links: nil, meta: nil)
    response = { data: data }
    response[:links] = links if links
    response[:meta] = meta if meta

    render json: response, status: status
  end
end
