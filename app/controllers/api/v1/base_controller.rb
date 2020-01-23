module Api
  module V1
    class BaseController < Api::BaseController
      include DeviseTokenAuth::Concerns::SetUserByToken

      def includes
        params[:include]
      end
    end
  end
end
