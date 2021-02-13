module Api
  module V1
    class ChallengeCompletionsController < Api::BaseController
      def show
        challenge_completion = ChallengeCompletion.find_by(id: params[:id])
        authorize challenge_completion

        render json: ChallengeCompletionSerializer.new(challenge_completion).serialized_json
      end

      def index
        authorize ChallengeCompletion

        year = SelectProperYearLogic.new.call
        event = Event.find_by(year: year)
        participation = Participation.find_by(event: event, user: current_api_v1_user)

        challenge_completions = participation.challenge_completions
        render json: ChallengeCompletionSerializer.new(challenge_completions).serialized_json
      end

      def create
        authorize ChallengeCompletion

        challenge = Challenge.find_by(id: params[:challenge_id])
        participation = Participation.find_by(event_id: challenge.event_id, user: current_api_v1_user)
        toogle_service = ToogleChallengeCompletionService.new(challenge: challenge, participation: participation)

        if toogle_service.call
          render json: ChallengeCompletionSerializer.new(toogle_service.challenge_completion).serialized_json
        end
      end
    end
  end
end
