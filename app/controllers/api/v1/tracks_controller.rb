module Api
  module V1
    class TracksController < Api::BaseController
      before_action :authenticate_api_v1_user!, only: [:index, :upload]

      def show
        track = TrackFile.find(params[:id])
        render json: TrackFileSerializer.new(track).serialized_json, status: :ok
      end

      def index; end

      def upload
        service = UploadFileService.new(user: current_api_v1_user, params: upload_file_params)
        if service.call
          attachments = current_api_v1_user.current_participation&.tracks
          render json: FileSerializer.new(attachments).serialized_json, status: :ok
        else
          render_validation_errors(service.errors)
        end
      end

      def upload_file_params
        jsonapi_params.permit(file: {})
      end
    end
  end
end
