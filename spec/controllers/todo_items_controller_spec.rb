require 'rails_helper'

RSpec.describe TodoItemsController, type: :controller do
  let(:todo_list)  { create(:todo_list) }
  let(:todo_item)  { create(:todo_item) }
  let(:user)       { create(:user) }

  describe 'POST #create' do
    context 'Authorized todo list author' do
      before { login(todo_list.user) }

      context 'with valid attributes' do
        it 'saves a new todo item in database' do
          expect { post :create, params: { todo_list_id: todo_list, todo_item: attributes_for(:todo_item) } }.to change(TodoItem, :count).by(1)
        end

        it 'redirect to show view' do
          post :create, params: { todo_list_id: todo_list, todo_item: attributes_for(:todo_item) }
          expect(response).to redirect_to assigns(:todo_list)
        end
      end

      context 'with invalid attributes' do
        it 'does not save the todo_item' do
          expect do
            post :create, params: { todo_list_id: todo_list, todo_item: attributes_for(:todo_item, content: nil) }
          end.to_not change(TodoItem, :count)
        end

        it 're-render new view' do
          post :create, params: { todo_list_id: todo_list, todo_item: attributes_for(:todo_item, content: nil) }
          expect(response).to redirect_to assigns(:todo_list)
        end
      end
    end

    context 'Unauthorized user' do
      it 'redirect_to root_path' do
        post :create, params: { todo_list_id: todo_list, todo_item: attributes_for(:todo_item) }
        expect(response).to redirect_to root_path
      end
    end
  end
end
