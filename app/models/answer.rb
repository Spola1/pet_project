class Answer < ApplicationRecord
  include Commentable
  include Ownership

  acts_as_votable

  belongs_to :question
  belongs_to :user
  has_many :qs

  validates :body, presence: true

  def created_at_format
    created_at.strftime('%Y-%m-%d %H:%M:%S')
  end

  def answers_order
    question.answers.order(cached_votes_score: :desc)
  end
end
