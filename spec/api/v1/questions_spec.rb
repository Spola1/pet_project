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
      end
    end
  end
end
