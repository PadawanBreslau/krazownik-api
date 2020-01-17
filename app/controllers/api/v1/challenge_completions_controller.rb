module Api
  module V1
    class ChallengeCompletionsController < Api::BaseController
      def show
        challenge = ChallengeCompletion.find_by(id: params[:id])

        render json: ChallengeCompletionSerializer.new(challenge).serialized_json
      end

      def index
        year = SelectProperYearLogic.new.call
        event = Event.find_by(year: year)
        participation = Participation.find_by(event: event, user: current_api_v1_user)

        challenge_completions = participation.challenge_completions
        render json: ChallengeCompletionSerializer.new(challenge_completions).serialized_json
      end

      def create; end
    end
  end
end
