module Api
  module V1
    # rubocop:disable Metrics/ClassLength
    class PasswordsController < DeviseTokenAuth::PasswordsController
      include DeviseTokenAuthResponses
      include JsonApiHeaders
      include UserHeaders

      protected

      def render_new_error
        render_devise_error(
          status: :method_not_allowed,
          title: I18n.t('devise_token_auth.passwords.new_not_supported')
        )
      end

      def render_create_error_missing_email
        render_devise_error(
          status: :unauthorized,
          title: I18n.t('devise_token_auth.passwords.missing_email')
        )
      end

      def render_create_error_missing_redirect_url
        render_devise_error(
          status: :unauthorized,
          title: I18n.t('devise_token_auth.passwords.missing_redirect_url')
        )
      end

      def render_create_error_not_allowed_redirect_url
        render_devise_error(
          status: :unprocessable_entity,
          title: I18n.t('devise_token_auth.passwords.not_allowed_redirect_url',
                        redirect_url: @redirect_url)
        )
      end

      def render_create_success
        render_devise_success(
          status: :ok,
          message: I18n.t('devise_token_auth.passwords.sended', email: @email)
        )
      end

      def render_create_error
        render_devise_error(
          status: :unprocessable_entity,
          title: I18n.t('devise_token_auth.passwords.user_validation_failed'),
          detail: @resource.errors.full_messages.join(', ')
        )
      end

      def render_edit_error
        render_devise_error(
          status: :not_found,
          title: I18n.t('devise_token_auth.registrations.user_not_found')
        )
      end

      def render_update_error_unauthorized
        render_devise_error(
          status: :unauthorized,
          title: 'Unauthorized'
        )
      end

      def render_update_error_password_not_required
        render_devise_error(
          status: :unprocessable_entity,
          title: I18n.t('devise_token_auth.passwords.password_not_required',
                        provider: @resource.provider.humanize)
        )
      end

      def render_update_error_missing_password
        render_devise_error(
          status: :unprocessable_entity,
          title: I18n.t('devise_token_auth.passwords.missing_passwords')
        )
      end

      def render_update_success
        render_devise_success(
          status: :ok,
          data: []
        )
      end

      def render_update_error
        render_devise_error(
          status: :unprocessable_entity,
          title: I18n.t('devise_token_auth.passwords.missing_passwords'),
          detail: @resource.errors.full_messages.join(', ')
        )
      end

      private

      def resource_params
        params['data']['attributes'].permit(
          :email,
          :reset_password_token,
          :redirect_url
        )
      end

      def edit_password_params
        params['data']['attributes'].permit(
          :reset_password_token,
          :redirect_url
        )
      end

      def password_resource_params
        params['data']['attributes'].permit(
          :password,
          :password_confirmation
        )
      end

      def render_not_found_error
        render_devise_success(
          status: :ok,
          message: I18n.t('devise_token_auth.passwords.sended', email: @email)
        )
      end

      def redirect_url_base
        URI.join(ENV.fetch('RESET_PASSWORD_REDIRECT_URL_BASE'), edit_password_params[:redirect_url])
      end

      def redirect_header_options
        { 'Reset-Password' => true, 'Uid' => @resource.email }
      end

      def redirect_headers
        client_id, token = @resource.create_token
        @resource.save!
        build_redirect_headers(
          token,
          client_id,
          redirect_header_options
        )
      end
    end
    # rubocop:enable Metrics/ClassLength
  end
end
