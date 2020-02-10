module Api
  module V1
    class TeamsController < Api::BaseController
      def show
        team = Team.find_by(id: params[:id])
        options = { include: [:participations] }

        render json: TeamSerializer.new(team, options).serialized_json
      end

      def index
        teams = Team.all
        options = { include: [:participations] }

        render json: TeamSerializer.new(teams, options).serialized_json
      end
    end
  end
end
