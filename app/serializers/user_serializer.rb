class UserSerializer < ApplicationSerializer
  attributes :id, :name, :nickname, :email, :role, :banned
end
