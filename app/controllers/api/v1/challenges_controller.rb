module Api
  module V1
    class ChallengesController < Api::BaseController
      before_action :authenticate_api_v1_user!, only: [:draw, :toggle]

      def show
        challenge = Challenge.find_by(id: params[:id])
        authorize challenge

        options = {
          include: [:challenge_conditions, :challenge_completions],
          params: { user: current_api_v1_user }
        }

        render json: ChallengeSerializer.new(challenge,
                                             options).serialized_json
      end

      def index
        authorize Challenge

        year = SelectProperYearLogic.year
        event = Event.find_by(year: year)
        options = {
          include: [:challenge_conditions, :challenge_completions],
          params: { user: current_api_v1_user }
        }

        challenges = event&.challenges&.where(open: true)&.includes(
          [:challenge_completions, :challenge_conditions, icon_attachment: :blob])
        render json: ChallengeSerializer.new(challenges, options).serialized_json
      end

      def draw
        authorize Challenge

        service = DrawChallengeService.new(params: jsonapi_params.permit(:max_points), user: current_api_v1_user)
        options = {
          include: [:challenge_conditions, :challenge_completions, :event],
          params: { user: current_api_v1_user }
        }

        if service.call
          render json: ChallengeSerializer.new(service.challenge, options).serialized_json
        else
          render_error(status: :unprocessable_entity, title: service.error)
        end
      end

      def toggle
        challenge = Challenge.find(params[:id])
        authorize challenge

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
