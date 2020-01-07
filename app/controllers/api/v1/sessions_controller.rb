module Api
  module V1
    class SessionsController < DeviseTokenAuth::SessionsController
      include DeviseTokenAuthResponses
      include JsonApiHeaders
      include UserHeaders

      protected

      def render_new_error
        render_devise_error(
          status: :method_not_allowed,
          title: I18n.t('devise_token_auth.sessions.new_not_supported')
        )
      end

      def render_create_success
        options = {}
        options[:meta] = { candidate_id: @resource.candidate&.id }
        render json: UserSerializer.new(@resource, options).serialized_json, status: :ok
      end

      def render_create_error_not_confirmed
        render_devise_error(
          status: :unauthorized,
          title: I18n.t('devise_token_auth.sessions.not_confirmed', email: @resource.email)
        )
      end

      def render_create_error_account_locked
        render_devise_error(
          status: :unauthorized,
          title: I18n.t('devise.mailer.unlock_instructions.account_lock_msg')
        )
      end

      def render_create_error_bad_credentials
        render_devise_error(
          status: :unauthorized,
          title: I18n.t('devise_token_auth.sessions.bad_credentials')
        )
      end

      def render_destroy_success
        render_devise_success status: :ok
      end

      def render_destroy_error
        render_devise_error(
          status: :not_found,
          title: I18n.t('devise_token_auth.sessions.user_not_found')
        )
      end

      private

      def resource_params
        params['data']['attributes'].permit(
          [
            :email,
            :password
          ]
        )
      end
    end
  end
end
