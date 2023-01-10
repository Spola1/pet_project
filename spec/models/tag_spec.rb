require 'rails_helper'

RSpec.describe(Tag, type: :model) do
  let(:tag) { create(:tag) }
  VALID_HASHTAG_REGEX = /#[[:word:]-]+/

  it { should have_many(:questions).through(:question_tags) }
  it { should have_many(:question_tags).dependent(:destroy) }

  it { should validate_presence_of(:title) }

  describe 'validations' do
    it 'should not let a tag be created without an title' do
      tag.title = nil
      expect(tag).to_not(be_valid)
    end
  end

  describe 'valid hashtag regex' do
    it 'tag title should match to valid hashtag regex' do
      expect(tag.title).to(match(VALID_HASHTAG_REGEX))
    end

    it 'tag title should not match to valid hashtag regex' do
      tag.title = "test#{rand(999)}"
      expect(tag.title).not_to(match(VALID_HASHTAG_REGEX))
    end
  end
end
