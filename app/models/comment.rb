class Comment < ApplicationRecord
  include Ownership

  belongs_to :commentable, polymorphic: true
  belongs_to :user

  validates :body, presence: true

  def for?(commentable)
    commentable == self.commentable
  end

  def created_at_format
    created_at.strftime('%Y-%m-%d %H:%M:%S')
  end
end
