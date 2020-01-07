module Api
  module V1
    class ChallengesController < Api::BaseController
      def show
        @challenge = Challenge.find_by(id: params[:id])
        render json: ChallengeSerializer.new(@challege).serialized_json
      end

      def index
        year = SelectProperYearLogic.new.call
        event = Event.find_by(year: year)

        @challenges = event.challenges
        render json: ChallengeSerializer.new(@challeges).serialized_json
      end
    end
  end
end
