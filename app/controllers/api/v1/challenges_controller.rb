module Api
  module V1
    class ChallengesController < Api::BaseController
      def show
        challenge = Challenge.find_by(id: params[:id])
        options = {
          include: [:challenge_conditions]
        }

        render json: ChallengeSerializer.new(challenge, options).serialized_json
      end

      def index
        year = SelectProperYearLogic.new.call
        event = Event.find_by(year: year)

        challenges = event&.challenges.where(open: true)
        render json: ChallengeSerializer.new(challenges).serialized_json
      end
    end
  end
end
