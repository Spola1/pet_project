class Comment < ApplicationRecord
  belongs_to :commentable, polymorphic: true
  belongs_to :user

  validates :body, presence: true

  def for?(commentable)
    commentable == self.commentable    
  end
end
