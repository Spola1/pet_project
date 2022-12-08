class UserSerializer < ApplicationSerializer
  attributes :email
  has_many :answers
end
