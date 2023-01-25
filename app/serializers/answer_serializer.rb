class AnswerSerializer < ApplicationSerializer
  attributes :id, :body, :created_at, :updated_at

  belongs_to :question
  has_many :comments, as: :commentable
end
