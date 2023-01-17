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
    user.present? && (user.owner?(record) || user.admin_role? || user.moderator_role?)
  end

  def destroy?
    user.present? && (user.admin_role? || user.owner?(record))
  end
end
