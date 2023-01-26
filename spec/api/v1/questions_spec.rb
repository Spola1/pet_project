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

      it 'returns 200 status' do
        get '/api/v1/questions', params: { access_token: access_token.token }, headers: headers
        expect(response).to(be_successful)
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

      it 'returns 200 status' do
        expect(response).to(be_successful)
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

  describe "POST api/v1/questions" do
    context 'authorized with valid params' do
      let(:resource_owner) { create(:user) }
      let(:access_token) { create(:access_token, resource_owner_id: resource_owner.id) }

      it 'returns all public fields' do
        post '/api/v1/questions', params: { access_token: access_token.token, title: 'test test', body: 'test test' }
        expect(JSON.parse(response.body)['title']).to eq('test test')
        expect(JSON.parse(response.body)['body']).to eq('test test')
        expect(JSON.parse(response.body)['user_id']).to eq(resource_owner.id)
      end
    end

    context 'authorized with invalid params' do
      let(:resource_owner) { create(:user) }
      let(:access_token) { create(:access_token, resource_owner_id: resource_owner.id) }

      it 'returns all public fields' do
        post '/api/v1/questions', params: { access_token: access_token.token, title: 'test', body: 'test' }
        expect(JSON.parse(response.body)).to eq({"errors"=>{"body"=>["is too short (minimum is 5 characters)"], "title"=>["is too short (minimum is 5 characters)"]}})
      end
    end

    context 'unauthorized' do
      it 'returns 401 status if there is no access_token' do
        post '/api/v1/questions', params: { title: 'test test', body: 'test test' }
        expect(response.status).to(eq(401))
      end

      it 'returns 401 status if access_token is invalid' do
        post '/api/v1/questions', params: { access_token: '123', title: 'test test', body: 'test test' }
        expect(response.status).to(eq(401))
      end
    end
  end

  describe "DELETE api/v1/questions/[:id]" do
    let!(:question_1)  { create(:question) }
    let!(:question_2)  { create(:question) }
    let!(:access_token) { create(:access_token, resource_owner_id: question_1.user_id) }
    
    context 'authorized with valid params' do
      it 'should delete the question' do
        delete "/api/v1/questions/#{question_1.id}", params: { access_token: access_token.token }
        expect(Question.all).to eq ([question_2])
        expect(response.status).to eq(200)
      end
    end

    context 'authorized with invalid params' do
      it 'should delete the question' do
        delete "/api/v1/questions/#{question_1.id+10}", params: { access_token: access_token.token }
        expect(response.status).to eq(404)
      end
    end

    context 'unauthorized' do
      it 'should delete the question' do
        delete "/api/v1/questions/#{question_1.id}"
        expect(response.status).to eq(401)
      end
    end
  end
end
