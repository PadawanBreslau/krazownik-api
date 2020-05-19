class NoteSerializer
  include FastJsonapi::ObjectSerializer

  attributes :title, :content
end
