class ProjectPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope
    end
  end

  def create?
    @user.manager?
  end

  def update?
    @user.manager?
  end

  def destroy?
    @user.manager?
  end
end
