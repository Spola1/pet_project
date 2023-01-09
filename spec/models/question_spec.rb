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
end
