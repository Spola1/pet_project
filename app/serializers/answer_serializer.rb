class AnswerSerializer < ApplicationSerializer
  attributes :id, :body, :created_at, :updated_at, :qs

  belongs_to :user
  has_many :qs
end
