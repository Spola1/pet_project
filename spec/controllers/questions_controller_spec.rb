require 'rails_helper'

RSpec.describe(QuestionsController, type: :controller) do
  let(:question)  { create(:question) }
  let(:old_title) { question.title }
  let(:old_body)  { question.body }
  let(:user)      { create(:user) }

  describe 'GET #index' do
    let(:questions) { create_list(:question, 3) }

    before { get :index }

    it 'populates an array of all questions' do
      expect(assigns(:questions)).to(match_array(questions))
    end

    it 'renders index view' do
      expect(response).to(render_template(:index))
    end
  end

  describe 'Get #show' do
    before { get :show, params: { id: question } }
    it 'renders show view' do
      expect(response).to(render_template(:show))
    end

    it 'assigns the requested question to @question' do
      expect(assigns(:question)).to(eq(question))
    end
  end

  describe 'Get #new' do
    context 'Authorized user' do
      before do
        login(user)
        get :new
      end

      it 'render new view' do
        expect(response).to(render_template(:new))
      end

      it 'assign a new question to @question' do
        expect(assigns(:question)).to(be_a_new(Question))
      end
    end

    context 'Unauthorized user' do
      it 'redirect to root_path' do
        get :new
        expect(response).to(redirect_to(root_path))
      end
    end
  end

  describe 'Get #edit' do
    context 'Authorized author' do
      it 'render edit view when user is question author' do
        login(question.user)
        get :edit, params: { id: question }
        expect(response).to(render_template(:edit))
      end
    end

    context 'Authorized user' do
      it 'render root_path view when user is not question author' do
        login(user)
        get :edit, params: { id: question }
        expect(response).to(redirect_to(root_path)) # || render_template nil
      end
    end

    context 'Unauthorized user' do
      it 'redirect to root_path' do
        get :edit, params: { id: question }
        expect(response).to(redirect_to(root_path))
      end
    end
  end

  describe 'POST #create' do
    context 'Authorized user' do
      before { login(user) }

      context 'with valid attributes' do
        it 'saves a new question in database' do
          expect { post(:create, params: { question: attributes_for(:question) }) }.to(change(Question, :count).by(1))
        end

        it 'redirect to show view' do
          post :create, params: { question: attributes_for(:question) }
          expect(response).to(redirect_to(assigns(:question)))
        end
      end

      context 'with invalid attributes' do
        it 'does not save the question' do
          expect do
            post(:create, params: { question: attributes_for(:question, title: nil) })
          end.to_not(change(Question, :count))
        end

        it 're-render new view' do
          post :create, params: { question: attributes_for(:question, title: nil) }
          expect(response).to(render_template(:new))
        end
      end
    end

    context 'Unauthorized user' do
      context 'with valid attributes' do
        it 'not save a new question in database' do
          expect { post(:create, params: { question: attributes_for(:question) }) }.to_not(change(Question, :count))
        end

        it 'redirect to root_path' do
          post :create, params: { question: attributes_for(:question) }
          expect(response).to(redirect_to(root_path))
        end
      end

      context 'with invalid attributes' do
        it 'does not save the question in database' do
          expect do
            post(:create, params: { question: attributes_for(:question, title: nil) })
          end.to_not(change(Question, :count))
        end

        it 'redirect to root_path' do
          post :create, params: { question: attributes_for(:question) }
          expect(response).to(redirect_to(root_path))
        end
      end
    end
  end

  describe 'PATCH #update' do
    context 'Authorized author' do
      before { login(question.user) }

      context 'with valid attributes' do
        it 'assing requested questions to @question' do
          patch :update, params: { id: question, question: attributes_for(:question) }
          expect(assigns(:question)).to(eq(question))
        end

        it 'change question attributes' do
          patch :update, params: { id: question, question: { title: 'new title', body: 'new body' } }
          question.reload

          expect(question.title).to(eq('new title'))
          expect(question.body).to(eq('new body'))
        end

        it 'redirect to updated question show view' do
          patch :update, params: { id: question, question: attributes_for(:question) }
          expect(response).to(redirect_to(question))
        end
      end

      context 'with invalid attributes' do
        before { patch :update, params: { id: question, question: attributes_for(:question, title: nil) } }

        it 'does not change question' do
          question.reload

          expect(question.title).to(eq(old_title))
          expect(question.body).to(eq(old_body))
        end

        it 're-render update view' do
          expect(response).to(render_template(:edit))
        end
      end
    end

    context 'Authorized user' do
      before { login(user) }

      it 'render root_path view when user is not question author' do
        patch :update, params: { id: question }
        expect(response).to(redirect_to(root_path)) # || render_template nil
      end
    end

    context 'Unauthorized user' do
      it 'render root_path view when user is not authorized' do
        patch :update, params: { id: question }
        expect(response).to(redirect_to(root_path)) # || render_template nil
      end
    end
  end

  describe 'DELETE #destroy' do
    context 'Authorized author' do
      before { login(question.user) }

      it 'delete the question' do
        expect { delete(:destroy, params: { id: question }) }.to(change(Question, :count).by(-1))
      end

      it 'redirect to questions path' do
        delete :destroy, params: { id: question }
        expect(response).to(redirect_to(questions_path))
      end
    end

    context 'Authorized user' do
      before { login(user) }
      let!(:question) { create(:question) }

      it 'not delete the question' do
        expect { delete(:destroy, params: { id: question }) }.to_not(change(Question, :count))
      end

      it 'redirect to root' do
        delete :destroy, params: { id: question }
        expect(response).to(redirect_to(root_path))
      end
    end

    context 'Unauthorized user' do
      let!(:question) { create(:question) }

      it 'not deletes the question' do
        expect { delete(:destroy, params: { id: question }) }.to_not(change(Question, :count))
      end

      it 'redirects to root path' do
        delete :destroy, params: { id: question }
        expect(response).to(redirect_to(root_path))
      end
    end
  end
end
