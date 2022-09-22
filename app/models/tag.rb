class Tag < ApplicationRecord
  VALID_HASHTAG_REGEX = /#[[:word:]-]+/

  has_many :question_tags, dependent: :destroy
  has_many :questions, through: :question_tags

  validates :title, presence: true
end
