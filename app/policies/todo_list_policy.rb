class TodoListPolicy < ApplicationPolicy
  def create?
    user.present?
  end

  def update?
    user.present? && user.owner?(record)
  end

  def index?
    user.present?
  end

  def show?
    user.present? && user.owner?(record)
  end

  def destroy?
    user.present? && user.owner?(record)
  end
end
