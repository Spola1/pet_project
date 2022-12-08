class AnswerSerializer < ApplicationSerializer
  belongs_to :user
  has_many :qs
end
