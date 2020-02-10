module Api
  module V1
    class ChallengesController < Api::BaseController
      before_action :authenticate_api_v1_user!, only: [:draw]

      def show
        challenge = Challenge.find_by(id: params[:id])
        options = {
          include: [:challenge_conditions]
        }

        render json: ChallengeSerializer.new(challenge, options).serialized_json
      end

      def index
        year = SelectProperYearLogic.year
        event = Event.find_by(year: year)

        challenges = event&.challenges&.where(open: true)
        render json: ChallengeSerializer.new(challenges).serialized_json
      end

      def draw
        authorize Challenge

        service = DrawChallengeService.new(params: jsonapi_params.permit(:max_points), user: current_api_v1_user)

        if service.call
          render json: ChallengeSerializer.new(service.challenge).serialized_json
        else
          render_error(status: :unprocessable_entity, title: service.error)
        end
      end
    end
  end
end
