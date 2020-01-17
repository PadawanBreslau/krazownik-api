module Api
  module V1
    class ChallengesController < Api::BaseController
      def show
        challenge = Challenge.find_by(id: params[:id])

        render json: ChallengeSerializer.new(challenge).serialized_json
      end

      def index
        year = SelectProperYearLogic.new.call
        event = Event.find_by(year: year)

        challenges = event&.challenges
        render json: ChallengeSerializer.new(challenges).serialized_json
      end
    end
  end
end
