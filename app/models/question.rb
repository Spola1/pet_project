class Question < ApplicationRecord
  include Commentable

  has_many :answers, dependent: :destroy
  belongs_to :user
  has_many :question_tags, dependent: :destroy
  has_many :tags, through: :question_tags

  validates :title, presence: true, length: { minimum: 5 }
  validates :body, presence: true, length: { minimum: 5 }

  after_create do
    question = Question.find_by(id: self.id)
    tags = self.body.scan(/#\w+/)
    tags.uniq.map do |tag|
      tag = Tag.find_or_create_by(title: tag.downcase.delete('#'))
      question.tags << tag
    end
  end

  before_update do
    question = Question.find_by(id: self.id)
    question.tags.clear
    tags = self.body.scan(/#\w+/)
    tags.uniq.map do |tag|
      tag = Tag.find_or_create_by(title: tag.downcase.delete('#'))
      question.tags << tag
    end
  end

  def created_at_format
    created_at.strftime('%Y-%m-%d %H:%M:%S')
  end
end
