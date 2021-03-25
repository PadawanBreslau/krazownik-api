module Api
  module V1
    class TeamTasksController < Api::BaseController
      def photo
        team = Team.find(params['team_id'])
        authorize team

        task = team.team_tasks.find(params['id'])

        require 'pry'; binding.pry
        service = UploadTaskPhotoService.new(user: user, params: upload_file_params)
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
