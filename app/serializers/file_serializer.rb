class FileSerializer
  include FastJsonapi::ObjectSerializer
  attributes :name, :created_at

  attribute :filename do |object|
    object.filename.to_s
  end
end
