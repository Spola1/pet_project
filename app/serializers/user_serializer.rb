class UserSerializer < ApplicationSerializer
  attributes :id, :email, :nickname, :name
  has_many :answers
end
