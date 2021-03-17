class CryptoParticipationPolicy < ApplicationPolicy
  def own?
    true
  end
end
