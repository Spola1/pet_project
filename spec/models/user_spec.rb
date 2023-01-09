require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { create(:user) }
  let(:user2) { create(:user) }
  let(:question) { create(:question) }

  it { should validate_presence_of :email }
  it { should validate_presence_of :password }
  it { should validate_presence_of :nickname }
  it { should validate_presence_of :name }

  it { should have_many(:questions) }
  it { should have_many(:answers) }
  it { should have_many(:todo_lists) }
  it { should have_many(:todo_items) }

  describe 'validations' do
    it 'should not let a user be created without an email' do
      user.email = nil
      expect(user).to_not be_valid
    end

    it 'should not let a user be created without an name' do
      user.name = nil
      expect(user).to_not be_valid
    end

    it 'should not let a user be created without an nickname' do
      user.nickname = nil
      expect(user).to_not be_valid
    end

    it 'should not let a user be created without an password' do
      user.password = nil
      expect(user).to_not be_valid
    end

    it 'should not let a user be created without an password confirmation' do
      user.password_confirmation = nil
      expect(user).to_not be_valid
    end
  end

  describe '#guest?' do
    it { expect(user.guest?).to be_falsey }
  end

  describe '#owner?(obj)' do
    it 'should return true' do
      question.user = user
      expect(user.owner?(question)).to eq true
    end

    it 'should return false' do
      question.user = user
      expect(user2.owner?(question)).to eq false
    end
  end
end
