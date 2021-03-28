class TeamTaskPhotoPolicy < ApplicationPolicy
  def show?
    true
  end

  def update?
    team_leader?
  end

  def destroy?
    team_leader?
  end

  private

  def team_leader?
    @record.team_task.team.leader?(@user.current_participation)
  end
end
