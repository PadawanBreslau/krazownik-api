module Api
  module V1
    class TeamTasksController < Api::BaseController
      def photo
        team = Team.find(params['team_id'])
        authorize team

        task = team.team_tasks.find(params['id'])

        service = UploadTaskPhotoService.new(user: current_api_v1_user, task: task, params: upload_file_params)
        if service.call
          options = {
            include: [:participations, :team_tasks, :'team_tasks.team_task_photos'],
            params: { user: current_api_v1_user }
          }
          render json: TeamSerializer.new(team, options).serialized_json
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
