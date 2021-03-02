class CryptoParticipationSerializer
  include FastJsonapi::ObjectSerializer

  has_many :crypto_riddle_solutions

  attributes :id, :solutions_size
  attribute :good_solutions, if: proc { |object, params| !params[:basic] || object.participation.user == params[:user] }
  attribute :bad_solutions, if: proc { |object, params| !params[:basic] || object.participation.user == params[:user] }

  attribute :good_solutions_size do |object|
    object.good_solutions.size
  end

  attribute :bad_solutions_size do |object|
    object.bad_solutions.size
  end

  attribute :name do |object|
    object.participation.user.name
  end

  attribute :avatar do |object|
    object.participation.user.avatar
  end
end
