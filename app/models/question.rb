class Question < ApplicationRecord
  include Commentable
  
  has_many :answers, dependent: :destroy
  belongs_to :user

  validates :title, presence: true, length: { minimum: 5 }
  validates :body, presence: true, length: { minimum: 5 }

  def created_at_format
    created_at.strftime('%Y-%m-%d %H:%M:%S')
  end
end
