class User < ApplicationRecord
  include Gravtastic

  enum role: { basic: 0, moderator: 1, admin: 2 }, _suffix: :role

  gravtastic(secure: true, filetype: :png, size: 40, default: 'retro')

  attr_accessor :old_password, :admin_edit

  has_many :questions
  has_many :answers
  has_many :todo_lists
  has_many :todo_items

  has_secure_password validations: false

  validate :password_presence
  validate :correct_old_password, on: :update, if: -> { password.present? && !admin_edit }
  validates :password, confirmation: true, allow_blank: true,
                       length: { minimum: 3, maximum: 70 }

  validates :email, presence: true, uniqueness: true, 'valid_email_2/email': true
  validates :name, presence: true
  validates :nickname, presence: true, uniqueness: true

  def owner?(obj)
    obj.user == self
  end

  def guest?
    false
  end

  private

  def correct_old_password
    return if BCrypt::Password.new(password_digest_was).is_password?(old_password)

    errors.add(:old_password, 'is incorrect')
  end

  def password_presence
    errors.add(:password, :blank) unless password_digest.present?
  end
end
