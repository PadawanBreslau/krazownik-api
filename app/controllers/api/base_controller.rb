module Api
  class BaseController < ActionController::API
    include DeviseTokenAuth::Concerns::SetUserByToken
    include Pundit
    include JsonApiResponses
    include JsonApiHeaders
    include UserHeaders

    rescue_from ActiveRecord::RecordNotFound, with: :not_found_error
    rescue_from Pundit::NotAuthorizedError, with: :not_authorized_error
    rescue_from ActionController::ParameterMissing, with: :bad_request_error

    def pagination_dict(collection)
      {
        current_page: collection.current_page,
        next_page: collection.next_page,
        prev_page: collection.prev_page,
        total_pages: collection.total_pages,
        total_count: collection.total_count,
        page_size: collection.limit_value
      }
    end

    private

    def jsonapi_params
      params.require(:data).require(:attributes)
    end

    def not_found_error
      render_error(status: :not_found,
                   title: 'Record not found.')
    end

    def not_authorized_error
      render_error(status: :forbidden,
                   title: 'Forbidden.')
    end

    def bad_request_error
      render_error(status: :bad_request,
                   title: 'Bad request.')
    end

    protected

    def pundit_user
      current_api_v1_user
    end
  end
end
