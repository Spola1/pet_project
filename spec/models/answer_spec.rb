require 'rails_helper'

RSpec.describe(Answer, type: :model) do
  let(:answer) { create(:answer) }

  it { should belong_to(:user) }
  it { should belong_to(:question) }
  it { should have_many(:qs) }

  it { should validate_presence_of(:body) }

  describe '#created_at_format' do
    it { expect(answer.created_at_format).to(eq(answer.created_at.strftime('%Y-%m-%d %H:%M:%S'))) }
  end

  it 'should be valid' do
    expect(answer).to(be_valid)
  end

  it 'should question create' do
    answer = create(:answer)
    assert answer.persisted?
  end

  describe 'validations' do
    it 'should not let a answer be created without an body' do
      answer.body = nil
      expect(answer).to_not(be_valid)
    end

    it 'should not let a answer be created without an user' do
      answer.user = nil
      expect(answer).to_not(be_valid)
    end

    it 'should not let a answer be created without an question' do
      answer.question = nil
      expect(answer).to_not(be_valid)
    end
  end
end
