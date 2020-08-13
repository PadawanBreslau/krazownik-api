module Api
  module V1
    class UsersController < Api::V1::BaseController
      before_action :authenticate_api_v1_user!, only: [:panel, :update]
      before_action :set_user!, only: [:update_password]

      def sign_up
        service = SignUpUserService.new(params: user_params)

        if service.call
          options = {}
          options[:meta] = { message: 'User successfully created' }
          render json: UserSerializer.new(service.user, options).serialized_json, status: :created

        else
          render_error(status: :unprocessable_entity,
                       title: 'Wrong data',
                       detail: service.error_msg)
        end
      end

      def panel
        options = { include: [:participations] }
        render json: UserSerializer.new(current_api_v1_user, options).serialized_json, status: :ok
      end

      def update
        user = User.find(params[:id].to_i)
        #### TODO
        #### VALIDATE PHONE
        options = { include: [:participations] }

        if user.update(user_params)
          render json: UserSerializer.new(user, options).serialized_json, status: :ok
        else
          render_error(status: :unprocessable_entity,
                       title: 'Wrong data',
                       detail: user_params.to_s)
        end
      end

      def reset_password
        authorize User
        user = User.find_by(email: jsonapi_params[:email]&.downcase)
        user&.send_reset_password_instructions
        message = 'Check your email for next instructions if account exists.'
        render_success(meta: { message: message })
      end

      def update_password
        authorize User
        if @user.reset_password(user_params[:password], user_params[:password_confirm])

          render_success(meta: { message: 'Password updated.',
                                 name: @user.name })
        else
          render_error(status: :unprocessable_entity,
                       title: 'Wrong data',
                       detail: @user.errors.full_messages.join(', '))
        end
      end

      private

      def set_user!
        @user = User.with_reset_password_token(request.headers['Access-Token'])
        raise ActiveRecord::RecordNotFound unless @user
      end

      def user_params
        jsonapi_params.permit(:email, :name, :phone_number, :send_messages, :send_riddles,
                              :password, :password_confirmation, :privacy_policy_accepted, :team_ready)
      end
    end
  end
end
