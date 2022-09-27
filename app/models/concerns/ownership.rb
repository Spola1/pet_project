module Ownership
  extend ActiveSupport::Concern

  included do
    def ownered_by?(user)
      self.user == user
    end
  end
end
