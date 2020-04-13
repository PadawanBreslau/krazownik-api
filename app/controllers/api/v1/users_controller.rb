module Api
  module V1
    class UsersController < Api::V1::BaseController
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
        user = User.find(id: params[:id])

        if user.update(user_params)
          render json: UserSerializer.new(service.user, options).serialized_json, status: :ok
        else
          render_error(status: :unprocessable_entity,
                       title: 'Wrong data',
                       detail: user_params.to_s)
        end
      end

      private

      def user_params
        jsonapi_params.permit(:email, :name, :password, :password_confirmation)
      end
    end
  end
end
