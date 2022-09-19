class Answer < ApplicationRecord
  belongs_to :question
  belongs_to :user

  validates :body, presence: true, length: { minimum: 5 }

  def created_at_format
    created_at.strftime('%Y-%m-%d %H:%M:%S')
  end
end
