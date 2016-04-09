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

  def index?
    @user.manager?
  end

  def show?
    @user.manager? or @user.projects.include?(record)
  end
end
