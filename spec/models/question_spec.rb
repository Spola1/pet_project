require 'rails_helper'

RSpec.describe Question, type: :model do
  let(:question) { create(:question) }

  it { should belong_to(:user) }
  it { should have_many(:answers).dependent(:delete_all) }
  it { should have_many(:question_tags).dependent(:destroy) }
  it { should have_many(:tags).through(:question_tags) }

  it { should validate_presence_of :title }
  it { should validate_presence_of :body }

  describe '#created_at_format' do
    it { expect(question.created_at_format).to eq question.created_at.strftime('%Y-%m-%d %H:%M:%S') }
  end

  it 'should be valid' do
    expect(question).to(be_valid)
  end

  it 'should question create' do
    question = create(:question)
    assert question.persisted?
  end

  describe 'validations' do
    it 'should not let a question be created without an title' do
      question.title = nil
      expect(question).to_not be_valid
    end

    it 'should not let a question be created without an body' do
      question.body = nil
      expect(question).to_not be_valid
    end

    it 'should not let a question be created without user' do
      question.user = nil
      expect(question).to_not be_valid
    end
  end
end
