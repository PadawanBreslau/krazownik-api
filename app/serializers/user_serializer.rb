class UserSerializer
  include FastJsonapi::ObjectSerializer

  set_key_transform :underscore
  set_type :user
  set_id :id

  attribute :reset_password_url, if: proc { |record| record.respond_to?(:reset_password_url) }
  attributes :name, :email, :phone_number, :send_messages, :send_riddles,
             :created_at, :privacy_policy_accepted, :team_ready

  has_many :participations
end
