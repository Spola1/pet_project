require 'rails_helper'

RSpec.describe(UsersController, type: :controller) do
  let(:user)      { create(:user) }
  let(:old_email) { user.email }
  let(:user2)     { create(:user) }

  describe 'Get #show' do
    before { get :show, params: { id: user } }
    it 'renders show view' do
      expect(response).to(render_template(:show))
    end

    it 'assigns the requested question to @user' do
      expect(assigns(:user)).to(eq(user))
    end
  end

  describe 'Get #edit' do
    context 'Authorized user' do
      it 'render edit view' do
        login(user)
        get :edit, params: { id: user }
        expect(response).to(render_template(:edit))
      end
    end

    context 'Authorized user' do
      it 'render root_path view when user is not current_user' do
        login(user)
        get :edit, params: { id: user2 }
        expect(response).to(redirect_to(root_path)) # || render_template nil
      end
    end

    context 'Unauthorized user' do
      it 'render root_path view' do
        get :edit, params: { id: user2 }
        expect(response).to(redirect_to(root_path))
      end
    end

    describe 'POST #create' do
      context 'with valid attributes' do
        it 'saves a new question in database' do
          expect { post(:create, params: { user: attributes_for(:user) }) }.to(change(User, :count).by(1))
        end

        it 'redirects to root path view' do
          post :create, params: { user: attributes_for(:user) }
          expect(response).to(redirect_to(root_path))
        end
      end

      context 'with invalid attributes' do
        it 'does not save the user' do
          expect do
            post(:create, params: { user: attributes_for(:user, email: nil) })
          end.to_not(change(User, :count))
        end

        it 're-renders new view' do
          post :create, params: { user: attributes_for(:user, email: nil) }
          expect(response).to(render_template(:new))
        end
      end
    end

    describe 'PATCH #update' do
      context 'Authorized user' do
        before { login(user) }

        context 'with valid attributes' do
          it 'assing requested user to @user' do
            patch :update, params: { id: user, user: attributes_for(:user) }
            expect(assigns(:user)).to(eq(user))
          end

          it 'change user attributes' do
            patch :update, params: { id: user, user: { email: 'qq@qq.com' } }
            user.reload

            expect(user.email).to(eq('qq@qq.com'))
          end

          it 'redirect to user after update' do
            patch :update, params: { id: user, user: attributes_for(:user) }
            expect(response.status).to(eq(200))
            expect(response.request.path).to(eq("/users/#{user.id}"))
          end
        end

        context 'with invalid attributes' do
          before { patch :update, params: { id: user, user: attributes_for(:user, email: nil) } }

          it 'does not change user' do
            user.reload

            expect(user.email).to(eq(old_email))
          end

          it 're-render update view' do
            expect(response).to(render_template(:edit))
          end
        end

        it 'render root_path view when user is not current_user' do
          patch :update, params: { id: user2 }
          expect(response).to(redirect_to(root_path)) # || render_template nil
        end
      end

      context 'Unauthorized user' do
        it 'render root_path view when user is not authorized' do
          patch :update, params: { id: user }
          expect(response).to(redirect_to(root_path)) # || render_template nil
        end
      end
    end
  end
end
