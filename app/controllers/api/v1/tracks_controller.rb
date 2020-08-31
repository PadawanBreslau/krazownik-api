module Api
  module V1
    class TracksController < Api::BaseController
      before_action :authenticate_api_v1_user!, only: [:show, :index, :upload, :all]

      def show
        track = TrackFile.find(params[:id])
        options = { include: [:gpx_points] }
        render json: TrackFileSerializer.new(track, options).serialized_json, status: :ok
      end

      def index
        service = TracksService.new(user: current_api_v1_user, params: params)
        service.call

        tracks = service.results

        options = { meta: pagination_dict(tracks), include: [:gpx_points] }
        options[:meta][:sort_options] = service.class::SORT_OPTIONS_METATAGS

        render json: TrackFileSerializer.new(tracks, options).serialized_json
      end

      def all
        year = params[:id].to_i
        event = Event.find_by(year: year)

        tracks = current_api_v1_user.track_files.where(event_id: event.id)
        options = { include: [:gpx_points] }

        render json: TrackFileSerializer.new(tracks, options).serialized_json
      end

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
