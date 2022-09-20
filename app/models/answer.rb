class Answer < ApplicationRecord
  include Commentable
  
  belongs_to :question
  belongs_to :user

  validates :body, presence: true

  def created_at_format
    created_at.strftime('%Y-%m-%d %H:%M:%S')
  end
end
