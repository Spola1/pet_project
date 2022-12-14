class AnswerPolicy < ApplicationPolicy
  def index?
    true
  end

  def show?
    true
  end

  def create?
    user.present? && user.banned != true
  end

  def update?
    user.admin_role? || user.moderator_role? || user.owner?(record)
  end

  def destroy?
    user.admin_role? || user.owner?(record)
  end
end
