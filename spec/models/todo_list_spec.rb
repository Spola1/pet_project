require 'rails_helper'

RSpec.describe(TodoList, type: :model) do
  let(:todo_list) { create(:todo_list) }

  it "should be valid" do
    expect(todo_list).to be_valid
  end

  it 'should todo_list create' do
    todo_list = create(:todo_list)
    assert todo_list.persisted?
  end
end
