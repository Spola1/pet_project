class TodoItem < ApplicationRecord
  belongs_to :todo_list
  belongs_to :user

  validates :content, presence: true

  def completed?
    completed_at.present?
  end
end
