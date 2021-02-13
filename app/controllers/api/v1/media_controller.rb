module Api
  module V1
    class MediaController < Api::BaseController
      before_action :authenticate_api_v1_user!, only: [:index, :upload]

      def index
        authorize Media

        service = PhotoService.new(user: current_api_v1_user, params: params)
        service.call

        photos = service.results

        options = { meta: pagination_dict(photos) }
        options[:meta][:sort_options] = service.class::SORT_OPTIONS_METATAGS

        render json: PhotoSerializer.new(photos, options).serialized_json
      end

      def upload
        authorize Media

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
