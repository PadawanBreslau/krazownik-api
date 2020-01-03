module Api
  module V1
    class ChallengesController < Api::BaseController
      # before_action :authenticate_api_v1_user!
      #
      def show
        @challenge = Challene.find_by(id: params[:id])
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
