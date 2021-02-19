class CryptoRiddleSolutionSerializer
  include FastJsonapi::ObjectSerializer

  attributes :id, :answer, :status
end
