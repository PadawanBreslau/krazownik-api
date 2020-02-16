class UserSerializer
  include FastJsonapi::ObjectSerializer

  set_key_transform :underscore
  set_type :user
  set_id :id

  attribute :reset_password_url, if: proc { |record| record.respond_to?(:reset_password_url) }
  attribute :name, :email, :created_at

  has_many :participations
end
