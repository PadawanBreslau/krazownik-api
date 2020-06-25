class ResultSerializer
  include FastJsonapi::ObjectSerializer

  has_one :participation
  attributes :result, :total
end
