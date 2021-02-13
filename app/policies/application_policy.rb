class ApplicationPolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end

  def show?
    true
  end

  def index?
    true
  end

  def edit?
    false
  end

  def update?
    false
  end

  def destroy?
    false
  end

  def owner?
    record.user == user
  end
end
