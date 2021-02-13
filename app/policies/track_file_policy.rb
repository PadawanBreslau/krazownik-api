class TrackFilePolicy < ApplicationPolicy
  def index_all
    true
  end

  def update?
    owner?
  end

  def destroy?
    owner?
  end
end
