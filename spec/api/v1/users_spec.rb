require 'rails_helper'

describe 'Users API', type: :request do
  let(:headers) do
    { "CONTENT_TYPE": 'application/json',
      "ACCEPT": 'application/json' }
  end

  describe 'GET /api/v1/users' do
    context 'unauthorized' do
      it 'returns 401 status if there is no access_token' do
        get '/api/v1/users', headers: headers
        expect(response.status).to(eq(401))
      end
      it 'returns 401 status if access_token is invalid' do
        get '/api/v1/users', params: { access_token: '1234' }, headers: headers
        expect(response.status).to(eq(401))
      end
    end

    context 'authorized' do
      let(:access_token) { create(:access_token) }

      it 'returns 200 status' do
        get '/api/v1/users', params: { access_token: access_token.token }, headers: headers
        expect(response).to(be_successful)
      end
    end
  end

  describe 'GET /api/v1/users/me' do
    context 'unauthorized' do
      it 'returns 401 status if there is no access_token' do
        get '/api/v1/users/me', headers: headers
        expect(response.status).to(eq(401))
      end
      it 'returns 401 status if access_token is invalid' do
        get '/api/v1/users/me', params: { access_token: '1234' }, headers: headers
        expect(response.status).to(eq(401))
      end
    end

    context 'authorized' do
      let(:me) { create(:user) }
      let(:access_token) { create(:access_token, resource_owner_id: me.id) }

      before { get '/api/v1/users/me', params: { access_token: access_token.token }, headers: headers }

      it 'returns 200 status' do
        expect(response).to(be_successful)
      end

      it 'returns all public fields' do
        json = JSON.parse(response.body)
        expect(json['id']).to(eq(me.id))
        expect(json['nickname']).to(eq(me.nickname))
        expect(json['email']).to(eq(me.email))
      end
    end

    context 'authorized' do
      let(:user_1) { create(:user) }
      let(:user_2) { create(:user) }
      let(:access_token) { create(:access_token, resource_owner_id: user_1.id) }

      before { get "/api/v1/users/#{user_2.id}", params: { access_token: access_token.token }, headers: headers }

      it 'returns 200 status' do
        expect(response).to(be_successful)
      end

      it 'returns all public fields' do
        json = JSON.parse(response.body)
        expect(json['id']).to(eq(user_2.id))
      end
    end
  end
end
