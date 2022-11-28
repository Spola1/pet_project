class TodoList < ApplicationRecord
  has_many :todo_items, dependent: :destroy
  belongs_to :user
end
