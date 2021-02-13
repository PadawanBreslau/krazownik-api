class UserSerializer
  include FastJsonapi::ObjectSerializer
  include ImageHelper

  set_key_transform :underscore
  set_type :user
  set_id :id

  has_many :participations

  attribute :reset_password_url, if: proc { |record| record.respond_to?(:reset_password_url) }
  attributes :name, :email, :phone_number, :send_messages, :send_riddles, :birthyear,
             :created_at, :privacy_policy_accepted, :team_ready, :about_me

  attribute :avatar do |object|
    image_path(object: object, image_field: :avatar, resize: '120x120')
  end
end
