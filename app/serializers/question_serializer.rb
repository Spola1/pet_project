class QuestionSerializer < ApplicationSerializer
  attributes :id, :title, :body, :answers

  has_many :answers
end
