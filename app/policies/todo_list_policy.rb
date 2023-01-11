class TodoListPolicy < ApplicationPolicy
  def create?
    user.present?
  end

  def update?
    user.admin_role? || user.moderator_role? || user.owner?(record)
  end

  def index?
    user.present?
  end

  def show?
    user.present? && user.owner?(record) || user.admin_role? || user.moderator_role?
  end

  def destroy?
    user.present? && user.owner?(record) || user.admin_role?
  end
end
