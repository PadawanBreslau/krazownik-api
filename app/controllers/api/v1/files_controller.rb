module Api
  module V1
    class FilesController < Api::BaseController
      def index
        render json: {}, status: :ok
      end
    end
  end
end
