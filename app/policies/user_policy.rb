class UserPolicy < ApplicationPolicy
  def sign_up?
    true
  end

  def reset_password?
    true
  end

  def update_password?
    true
  end
end
