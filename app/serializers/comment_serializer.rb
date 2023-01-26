class CommentSerializer < ApplicationSerializer
  attributes :id, :body, :created_at, :updated_at

  belongs_to :commentable, polymorphic: true
end
