class Question < ApplicationRecord
  include Commentable

  has_many :answers, dependent: :destroy
  belongs_to :user
  has_many :question_tags, dependent: :destroy
  has_many :tags, through: :question_tags

  validates :title, presence: true, length: { minimum: 5 }
  validates :body, presence: true, length: { minimum: 5 }

  scope :all_by_tags, ->(tag_ids) do
    questions = includes(:user)
    if tag_ids
      questions = questions.includes(question_tags: :tag).joins(:tags).where(tags: tag_ids)
    else
      questions = questions.includes(:question_tags, :tags)
    end

    questions.order(created_at: :desc)
  end

  def created_at_format
    created_at.strftime('%Y-%m-%d %H:%M:%S')
  end
end
