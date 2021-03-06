module Api
  module V1
    class FilesController < Api::BaseController
      before_action :authenticate_api_v1_user!, only: [:index, :upload]

      def index
        authorize Files

        attachments = current_api_v1_user.current_participation&.files
        render json: FileSerializer.new(attachments).serialized_json, status: :ok
      end

      def upload
        authorize File

        service = UploadFileService.new(user: current_api_v1_user, params: upload_file_params)
        if service.call
          attachments = current_api_v1_user.current_participation&.files
          render json: FileSerializer.new(attachments).serialized_json, status: :ok
        else
          render json: ErrorSerializer.serialize(service.errors), status: :unprocessable_entity
        end
      end

      private

      def upload_file_params
        jsonapi_params.permit(file: {})
      end
    end
  end
end
