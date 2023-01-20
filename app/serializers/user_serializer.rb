class UserSerializer < ApplicationSerializer
  attributes :id, :email, :nickname
  has_many :answers
end