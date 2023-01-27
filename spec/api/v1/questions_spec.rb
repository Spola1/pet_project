require 'rails_helper'

describe 'Questions API', type: :request do
  let(:headers) do
    { "CONTENT_TYPE": 'application/json',
      "ACCEPT": 'application/json' }
  end

  describe 'GET /api/v1/questions' do
    context 'unauthorized' do
      it 'returns 401 status if there is no access_token' do
        get '/api/v1/questions', headers: headers
        expect(response.status).to(eq(401))
      end

      it 'returns 401 status if access_token is invalid' do
        get '/api/v1/questions', params: { access_token: '1234' }, headers: headers
        expect(response.status).to(eq(401))
      end
    end

    context 'authorized' do
      let(:access_token) { create(:access_token) }
      let!(:questions) { create_list(:question, 3) }

      it 'should return status 200' do
        get '/api/v1/questions', params: { access_token: access_token.token }, headers: headers
        expect(response.status).to(eq(200))
      end

      it 'should return true' do
        get '/api/v1/questions', params: { access_token: access_token.token }, headers: headers
        response_size = JSON.parse(response.body).each { |h| h }.size
        expect(response_size).to(eq(questions.size))
      end
    end
  end

  describe 'GET /api/v1/questions/[:id]' do
    context 'unauthorized' do
      let(:question) { create(:question) }

      it 'returns 401 status if there is no access_token' do
        get "/api/v1/questions/#{question.id}", headers: headers
        expect(response.status).to(eq(401))
      end

      it 'returns 401 status if access_token is invalid' do
        get "/api/v1/questions/#{question.id}", params: { access_token: '1234' }, headers: headers
        expect(response.status).to(eq(401))
      end
    end

    context 'authorized' do
      let(:question) { create(:question) }
      let(:access_token) { create(:access_token, resource_owner_id: question.user_id) }

      before { get "/api/v1/questions/#{question.id}", params: { access_token: access_token.token }, headers: headers }

      it 'should return status 200' do
        expect(response.status).to(eq(200))
      end

      it 'returns all public fields' do
        json = JSON.parse(response.body)
        expect(json['id']).to(eq(question.id))
        expect(json['title']).to(eq(question.title))
        expect(json['body']).to(eq(question.body))
        expect(json['created_at'].to_date).to(eq(question.created_at.to_date))
        expect(json['updated_at'].to_date).to(eq(question.updated_at.to_date))
        expect(json['answers']).to(eq(question.answers))
        expect(json['user_id']).to(eq(question.user.id))
        expect(json['comments']).to(eq(question.comments))
      end
    end
  end

  describe 'POST api/v1/questions' do
    context 'unauthorized' do
      it 'should return 401 status if there is no access_token' do
        post '/api/v1/questions', params: { title: 'test test', body: 'test test' }
        expect(response.status).to(eq(401))
      end

      it 'should return 401 status if access_token is invalid' do
        post '/api/v1/questions', params: { access_token: '123', title: 'test test', body: 'test test' }
        expect(response.status).to(eq(401))
      end
    end

    context 'authorized with valid params' do
      let(:resource_owner) { create(:user) }
      let(:access_token) { create(:access_token, resource_owner_id: resource_owner.id) }

      before do
        post '/api/v1/questions', params: { access_token: access_token.token, title: 'test test', body: 'test test' }
      end

      it 'returns all public fields' do
        expect(JSON.parse(response.body)['title']).to(eq('test test'))
        expect(JSON.parse(response.body)['body']).to(eq('test test'))
        expect(JSON.parse(response.body)['user_id']).to(eq(resource_owner.id))
      end

      it 'should return status 200' do
        expect(response.status).to(eq(200))
      end
    end

    context 'authorized with invalid params' do
      let(:resource_owner) { create(:user) }
      let(:access_token) { create(:access_token, resource_owner_id: resource_owner.id) }

      it 'should return question errors' do
        post '/api/v1/questions', params: { access_token: access_token.token, title: 'test', body: 'test' }
        expect(JSON.parse(response.body)).to(eq({ 'errors' => { 'body' => ['is too short (minimum is 5 characters)'],
                                                                'title' => ['is too short (minimum is 5 characters)'] } }))
      end
    end
  end

  describe 'DELETE api/v1/questions/[:id]' do
    let(:question_1)  { create(:question) }
    let(:question_2)  { create(:question) }
    let(:access_token) { create(:access_token, resource_owner_id: question_1.user_id) }

    context 'unauthorized' do
      it 'should return 401 status if there is no access_token' do
        delete "/api/v1/questions/#{question_1.id}"
        expect(response.status).to(eq(401))
      end

      it 'should return 401 status if access_token is invalid' do
        delete "/api/v1/questions/#{question_1.id}", params: { access_token: '123' }
        expect(response.status).to(eq(401))
      end
    end

    context 'authorized with valid params' do
      before do
        delete "/api/v1/questions/#{question_1.id}", params: { access_token: access_token.token }
      end

      it 'should delete the question' do
        expect(Question.all).to(eq([question_2]))
      end

      it 'should return status 200' do
        expect(response.status).to(eq(200))
      end
    end

    context 'authorized with invalid params' do
      it 'should return status 404' do
        delete "/api/v1/questions/#{question_1.id + 10}", params: { access_token: access_token.token }
        expect(response.status).to(eq(404))
      end
    end
  end

  describe 'PATH api/v1/questions/[:id]' do
    let(:question)  { create(:question) }
    let(:old_title) { question.title }
    let(:old_body)  { question.body }
    let(:access_token) { create(:access_token, resource_owner_id: question.user_id) }

    context 'unauthorized' do
      it 'should return 401 status if there is no access_token' do
        patch "/api/v1/questions/#{question.id}", params: { title: 'update', body: 'update' }
        expect(response.status).to(eq(401))
      end

      it 'should return 401 status if access_token is invalid' do
        patch "/api/v1/questions/#{question.id}", params: { access_token: '123', title: 'update', body: 'update' }
        expect(response.status).to(eq(401))
      end
    end

    context 'authorized with valid params' do
      before do
        patch "/api/v1/questions/#{question.id}", params: { access_token: access_token.token, title: 'update', body: 'update' }
      end

      it 'should update the question' do
        expect(JSON.parse(response.body)['title']).to(eq('update'))
        expect(JSON.parse(response.body)['body']).to(eq('update'))
      end

      it 'should return status 200' do
        expect(response.status).to(eq(200))
      end
    end

    context 'authorized with invalid params' do
      it 'should not update the question' do
        patch "/api/v1/questions/#{question.id}", params: { access_token: access_token.token, title: 'upd', body: 'upd' }
        expect(JSON.parse(response.body)).to(eq({ 'errors' => { 'body' => ['is too short (minimum is 5 characters)'],
                                                                'title' => ['is too short (minimum is 5 characters)'] } }))
        expect(Question.find(question.id).title).to(eq(old_title))
        expect(Question.find(question.id).body).to(eq(old_body))
      end
    end
  end

  describe 'GET api/v1/questions/by_title' do
    let(:question) { create(:question) }
    let(:access_token) { create(:access_token, resource_owner_id: question.user_id) }

    context 'unauthorized' do
      it 'should return 401 status if there is no access_token' do
        get '/api/v1/questions/by_title', params: { title: question.title }
        expect(response.status).to(eq(401))
      end

      it 'should return 401 status if access_token is invalid' do
        get '/api/v1/questions/by_title', params: { access_token: '123', title: question.title }
        expect(response.status).to(eq(401))
      end
    end

    context 'authorized with valid params' do
      before do
        get '/api/v1/questions/by_title', params: { access_token: access_token.token, title: question.title }
      end

      it 'should return the question' do
        JSON.parse(response.body).each do |h|
          expect(h['title']).to(eq(question.title))
        end
      end

      it 'should return status 200' do
        expect(response.status).to(eq(200))
      end
    end

    context 'authorized with invalid params' do
      before do
        get '/api/v1/questions/by_title', params: { access_token: access_token.token, title: '' }
      end

      it 'should return error not found' do
        expect(JSON.parse(response.body)).to(eq({ 'error' => 'not found' }))
      end

      it 'should return status 404' do
        expect(response.status).to(eq(404))
      end
    end
  end
end
