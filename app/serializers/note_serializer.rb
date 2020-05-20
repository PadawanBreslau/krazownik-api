class NoteSerializer
  include FastJsonapi::ObjectSerializer

  attributes :title, :content, :created_at
end
