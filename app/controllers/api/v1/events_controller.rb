module Api
  module V1
    class EventsController < Api::BaseController
      def index
        authorize Event

        year = SelectProperYearLogic.year
        event = Event.find_by(year: year)

        if event
          render json: EventSerializer.new(event).serialized_json
        else
          render_error(status: :not_found, title: 'Event not found')
        end
      end
    end
  end
end
