module Api
  module V1
    class ChallengesController < Api::BaseController
      before_action :authenticate_api_v1_user!, only: [:draw, :toggle]

      def show
        challenge = Challenge.find_by(id: params[:id])
        options = {
          include: [:challenge_conditions, :challenge_completions]
        }

        render json: ChallengeSerializer.new(presenter_challenge(challenge, current_api_v1_user),
                                             options).serialized_json
      end

      def index
        year = SelectProperYearLogic.year
        event = Event.find_by(year: year)
        options = {
          include: [:challenge_conditions, :challenge_completions]
        }

        formatted_challenges = event&.challenges&.where(open: true)&.map do |chl|
          presenter_challenge(chl, current_api_v1_user)
        end

        render json: ChallengeSerializer.new(formatted_challenges, options).serialized_json
      end

      def draw
        authorize Challenge

        service = DrawChallengeService.new(params: jsonapi_params.permit(:max_points), user: current_api_v1_user)

        if service.call
          render json: ChallengeSerializer.new(presenter_challenge(service.challenge,
                                                                   current_api_v1_user)).serialized_json
        else
          render_error(status: :unprocessable_entity, title: service.error)
        end
      end

      def toggle
        authorize Challenge

        service = ToggleChallengeService.new(user: current_api_v1_user, challenge_id: params[:id].to_i)

        if service.call
          render json: ChallengeCompletionSerializer.new(service.challenge_completion).serialized_json
        else
          render_error(status: :unprocessable_entity, title: service.error)
        end
      end

      private

      def presenter_challenge(challenge, user)
        ChallengePresenter.new(challenge, user_context: user)
      end
    end
  end
end
