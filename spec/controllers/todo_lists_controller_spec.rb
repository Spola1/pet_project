require 'rails_helper'

RSpec.describe TodoListsController, type: :controller do
  let(:todo_list)  { create(:todo_list) }
  let(:old_title) { todo_list.title }
  let(:old_description)  { todo_list.description }
  let(:user)      { create(:user) }

  describe 'GET #index' do
    context 'Authorized user' do
      before do
        login(user)
        get :index
      end

      let(:todo_lists) { create_list(:todo_list, 3) }

      it 'populates an array of all todo_lists' do
        expect(assigns(:todo_lists)).to match_array(todo_lists)
      end

      it 'renders index view' do
        expect(response).to render_template :index
      end
    end

    context 'Unauthorized user' do
      it 'render root path' do
        get :index
        expect(response).to redirect_to root_path
      end
    end
  end

  describe 'Get #edit' do
    context 'Authorized author' do
      it 'render edit view when user is todo list author' do
        login(todo_list.user)
        get :edit, params: { id: todo_list }
        expect(response).to render_template :edit
      end
    end

    context 'Authorized user' do
      it 'render root_path view when user is not todo list author' do
        login(user)
        get :edit, params: { id: todo_list }
        expect(response).to redirect_to root_path #|| render_template nil
      end
    end

    context 'Unauthorized user' do
      it 'redirect_to root_path' do
        get :edit, params: { id: todo_list }
        expect(response).to redirect_to root_path
      end
    end
  end

  describe 'POST #create' do
    context 'Authorized user' do
      before { login(user) }

      context 'with valid attributes' do
        it 'saves a new todo list in database' do
          expect { post :create, params: { todo_list: attributes_for(:todo_list) } }.to change(TodoList, :count).by(1)
        end

        it 'redirect to show view' do
          post :create, params: { todo_list: attributes_for(:todo_list) }
          expect(response).to redirect_to assigns(:todo_list)
        end
      end

      context 'with invalid attributes' do
        it 'does not save the todo_list' do
          expect do
            post :create, params: { todo_list: attributes_for(:todo_list, title: nil) }
          end.to_not change(TodoList, :count)
        end

        it 're-render new view' do
          post :create, params: { todo_list: attributes_for(:todo_list, title: nil) }
          expect(response).to render_template :new
        end
      end
    end

    context 'Unauthorized user' do
      it 'redirect_to root_path' do
        post :create, params: { todo_list: attributes_for(:todo_list) }
        expect(response).to redirect_to root_path
      end
    end
  end

  describe 'Get #new' do
    context 'Authorized user' do
      before do
        login(user)
        get :new
      end

      it 'render new view' do
        expect(response).to render_template :new
      end

      it 'assign a new todo_list to @todo_list' do
        expect(assigns(:todo_list)).to be_a_new(TodoList)
      end
    end

    context 'Unauthorized user' do
      it 'redirect to root_path' do
        get :new
        expect(response).to redirect_to root_path
      end
    end
  end

  describe 'PATCH #update' do
    context 'Authorized author' do
      before { login(todo_list.user) }

      context 'with valid attributes' do
        it 'assing requested todo_list to @todo_list' do
          patch :update, params: { id: todo_list, todo_list: attributes_for(:todo_list) }
          expect(assigns(:todo_list)).to eq todo_list
        end

        it 'change todo_list attributes' do
          patch :update, params: { id: todo_list, todo_list: { title: 'new title', description: 'new description' } }
          todo_list.reload

          expect(todo_list.title).to eq 'new title'
          expect(todo_list.description).to eq 'new description'
        end

        it 'redirect to updated todo_list show view' do
          patch :update, params: { id: todo_list, todo_list: attributes_for(:todo_list) }
          expect(response).to redirect_to todo_list
        end
      end

      context 'with invalid attributes' do
        before { patch :update, params: { id: todo_list, todo_list: attributes_for(:todo_list, title: nil) } }

        it 'does not change todo_list' do
          todo_list.reload

          expect(todo_list.title).to eq old_title
          expect(todo_list.description).to eq old_description
        end

        it 're-render update view' do
          expect(response).to render_template :edit
        end
      end
    end

    context 'Authorized user' do
      before { login(user) }

      it 'render root_path view when user is not todo_list author' do
        patch :update, params: { id: todo_list }
        expect(response).to redirect_to root_path #|| render_template nil
      end
    end

    context 'Unauthorized user' do
      it 'render root_path view when user is not authorized' do
        patch :update, params: { id: todo_list }
        expect(response).to redirect_to root_path #|| render_template nil
      end
    end
  end

  describe 'DELETE #destroy' do
    context 'Authorized author' do
      before { login(todo_list.user) }

      it 'delete the todo_list' do
        expect { delete :destroy, params: { id: todo_list } }.to change(TodoList, :count).by(-1)
      end

      it 'redirect to todo_lists path' do
        delete :destroy, params: { id: todo_list }
        expect(response).to redirect_to todo_lists_path
      end
    end

    context 'Authorized user' do
      before { login(user) }
      let!(:todo_list) { create(:todo_list) }

      it 'not delete the todo_list' do
        expect { delete :destroy, params: { id: todo_list } }.to_not change(TodoList, :count)
      end

      it 'redirect to root' do
        delete :destroy, params: { id: todo_list }
        expect(response).to redirect_to root_path
      end
    end

    context 'Unauthorized user' do
      let!(:todo_list) { create(:todo_list) }

      it 'not deletes the todo_list' do
        expect { delete :destroy, params: { id: todo_list } }.to_not change(TodoList, :count)
      end

      it 'redirects to root path' do
        delete :destroy, params: { id: todo_list }
        expect(response).to redirect_to root_path
      end
    end
  end
end
