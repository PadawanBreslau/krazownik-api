module Api
  module V1
    class FilesController < Api::BaseController
      def index
        render json: {}, status: :ok
      end

      def upload
        service = UploadFileService.new(user: current_api_v1_user, params: upload_file_params)

        if service.call
          render json: {}, status: :ok
        else
          render json: ErrorSerializer.serialize(service.errors), status: :unprocessable_entity
        end
      end

      def upload_file_params
        jsonapi_params.permit(file: {})
      end
    end
  end
end
