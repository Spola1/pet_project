class QuestionSerializer < ApplicationSerializer
  attributes :id, :title, :body, :created_at, :updated_at, :user_id

  has_many :answers
  has_many :comments, as: :commentable
end
