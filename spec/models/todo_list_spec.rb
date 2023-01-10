require 'rails_helper'

RSpec.describe(TodoList, type: :model) do
  let(:todo_list) { create(:todo_list) }

  it { should have_many(:todo_items).dependent(:destroy) }
  it { should belong_to(:user) }

  it 'should be valid' do
    expect(todo_list).to(be_valid)
  end

  it 'should todo_list create' do
    todo_list = create(:todo_list)
    assert todo_list.persisted?
  end

  describe 'validations' do
    it 'should not let a todo_list be created without an content' do
      todo_list.title = nil
      expect(todo_list).to_not(be_valid)
    end

    it 'should not let a todo_list be created without an todo_list_id' do
      todo_list.description = nil
      expect(todo_list).to_not(be_valid)
    end

    it 'should not let a todo_list be created without user' do
      todo_list.user = nil
      expect(todo_list).to_not(be_valid)
    end
  end
end
