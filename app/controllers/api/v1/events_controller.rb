module Api
  module V1
    class EventsController < Api::BaseController
      # before_action :authenticate_api_v1_user!
      #
      def show
        year = SelectProperYearLogic.new.call
      end
    end
  end
end
