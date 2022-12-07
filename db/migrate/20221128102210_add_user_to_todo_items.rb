class AddUserToTodoItems < ActiveRecord::Migration[7.0]
  def change
    add_reference :todo_items, :user, null: false, foreign_key: true
  end
end
