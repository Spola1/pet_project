require 'rails_helper'

RSpec.describe(Comment, type: :model) do
  let(:comment) { create(:comment) }

  it { should belong_to(:commentable) }
  it { should belong_to(:user) }

  it { should validate_presence_of(:body) }

  it 'should be valid' do
    expect(comment).to(be_valid)
  end

  it 'should comment create' do
    comment = create(:comment)
    assert comment.persisted?
  end

  describe 'validations' do
    it 'should not let a comment be created without an body' do
      comment.body = nil
      expect(comment).to_not(be_valid)
    end

    it 'should not let a comment be created without an commentable_type' do
      comment.commentable_type = nil
      expect(comment).to_not(be_valid)
    end

    it 'should not let a comment be created without an user' do
      comment.user = nil
      expect(comment).to_not(be_valid)
    end

    it 'should not let a comment be created without an commentable_id' do
      comment.commentable_id = nil
      expect(comment).to_not(be_valid)
    end
  end
end
