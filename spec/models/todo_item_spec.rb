require 'rails_helper'

RSpec.describe(TodoItem, type: :model) do
  let(:todo_item) { create(:todo_item) }

  it { should belong_to(:todo_list) }
  it { should belong_to(:user) }

  describe '#completed?' do
    it { expect(todo_item.completed?).to eq todo_item.completed_at.present? }
  end

  it 'should be valid' do
    expect(todo_item).to(be_valid)
  end

  it 'should todo_list create' do
    todo_item = create(:todo_item)
    assert todo_item.persisted?
  end
end
