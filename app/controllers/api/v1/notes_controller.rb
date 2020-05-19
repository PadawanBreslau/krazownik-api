module Api
  module V1
    class NotesController < Api::BaseController
      def index
        notes = Note.last(10)

        render json: NoteSerializer.new(notes).serialized_json
      end
    end
  end
end
