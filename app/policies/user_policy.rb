class UserPolicy < ApplicationPolicy
  def create?
    true
  end

  def update?
    record == user
  end

  def index?
    false
  end

  def show?
    true
  end

  def destroy?
    false
  end
end
