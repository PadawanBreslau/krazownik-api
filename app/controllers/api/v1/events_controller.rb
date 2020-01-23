module Api
  module V1
    class EventsController < Api::BaseController
      before_action :authenticate_api_v1_user!

      def show
        year = SelectProperYearLogic.new.call
        event = Event.find_by(year: year)

        if event
          render json: EventSerializer.new(event).serialized_json
        else
          p 'raise error'
        end
      end
    end
  end
end
