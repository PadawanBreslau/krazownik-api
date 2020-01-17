module Api
  module V1
    class PariticpationsController < Api::BaseController
      def show
        participation = Participation.find_by(id: params[:id])

        if participation.user == current_api_v1_user
          render json: ParticipationSerializer.new(participation).serialized_json
        end
      end

      def index
        participations = current_api_v1_user.participations
        render json: ParticipationSerializer.new(participations).serialized_json
      end
    end
  end
end
