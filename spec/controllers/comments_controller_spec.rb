require 'rails_helper'

RSpec.describe CommentsController, type: :controller do
  let!(:user)     { create(:user) }
  let!(:question) { create(:question) }

  describe 'POST #create' do
    context 'Authorized user' do
      before { login(user) }

      context 'with valid attributes' do
        it 'saves a new question_with_comments in database' do
          expect do
            post :create, params: { question_id: question, comment: attributes_for(:comment) }
          end.to change(Comment, :count).by(1)
        end
      end

      context 'with invalid attributes' do
        it 'does not save the comment' do
          expect do
            post :create, params: { question_id: question, comment: attributes_for(:comment, body: nil) }
          end.to_not change(Comment, :count)
        end
      end
    end

    context 'Unauthorized user' do
      it 'can not create comment' do
        expect do
          post :create, params: { question_id: question, comment: attributes_for(:comment) }
        end.to_not change(Comment, :count)
      end
    end
  end
end
