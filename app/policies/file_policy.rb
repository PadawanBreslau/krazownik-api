class FilePolicy < ApplicationPolicy
  def index?
    true
  end

  def upload?
    true
  end
end
