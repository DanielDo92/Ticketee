class ProjectPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      return scope.none if user.nil?
      return scope.all.order(:name) if user.admin?
      scope.joins(:roles).where(roles: { user_id: user }).order(:name)
    end
  end

  def show?
    user.try(:admin?) || record.has_member?(user)
  end

  def update?
    user.try(:admin?) || record.has_manager?(user)
  end
end
