class TodoItemPolicy < ApplicationPolicy
  def create?
    user.present?
  end

  def destroy?
    user.present? && user.owner?(record)
  end

  def complete?
    user.present? && user.owner?(record)
  end
end
