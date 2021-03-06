class UserSerializer
  include FastJsonapi::ObjectSerializer
  include ImageHelper

  set_key_transform :underscore
  set_type :user
  set_id :id

  has_many :participations

  attribute :reset_password_url, if: proc { |record| record.respond_to?(:reset_password_url) }
  attributes :name, :email, :phone_number, :send_messages, :send_riddles, :birthyear,
             :created_at, :privacy_policy_accepted, :team_ready, :about_me, :viewable

  attributes :last_participation_year do |object|
    object.current_participation&.event&.year
  end

  attribute :phone_number do |object, params|
    object.phone_number if params[:user]&.allowed_to_contact?(object)
  end

  attribute :email do |object, params|
    object.email if params[:user]&.allowed_to_contact?(object)
  end

  attribute :avatar do |object|
    image_path(object: object, image_field: :avatar, resize: '120x120')
  end
end
