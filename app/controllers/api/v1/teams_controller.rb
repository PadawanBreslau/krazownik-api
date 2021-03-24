module Api
  module V1
    class TeamsController < Api::BaseController
      def show
        team = Team.find_by(id: params[:id])
        authorize team

        options = {
          include: [:participations, :team_tasks],
          params: { user: current_api_v1_user }
        }
        render json: TeamSerializer.new(team, options).serialized_json
      end

      def index
        authorize Team

        teams = Team.all.select(&:visible?)
        options = { include: [:participations] }

        render json: TeamSerializer.new(teams, options).serialized_json
      end
    end
  end
end
