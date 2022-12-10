require 'rails_helper'

RSpec.describe(TodoItem, type: :model) do
  let(:todo_item) { create(:todo_item) }

  it "should be valid" do
    expect(todo_item).to be_valid
  end

  it 'should todo_list create' do
    todo_item = create(:todo_item)
    assert todo_item.persisted?
  end
end
