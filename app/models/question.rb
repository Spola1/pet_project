class Question < ApplicationRecord
  validates :title, presence: true, length: { minimum: 2 }
  validates :body, presence: true, length: { minimum: 2 }

  def created_at_format
    created_at.strftime('%Y-%m-%d %H:%M:%S')
  end
end
