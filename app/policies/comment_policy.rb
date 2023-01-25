class CommentPolicy < ApplicationPolicy
  def create?
    user.present? && user.banned != true
  end
end
