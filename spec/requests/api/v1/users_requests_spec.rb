# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api', type: :request do
  let!(:user) { User.create!(
    first_name: 'jhon', last_name: 'petter', email: 'john.petter@gmail.com', address: 'California, USA'
  )}

  let!(:attributes) {
    { first_name: 'jhon1', last_name: 'petter1', email: 'jhon@gmail.com', address: 'California, USA' }
  }

  describe '#index' do
    it 'returns all users' do
      get api_v1_users_path
      expect(response).to be_successful
    end
  end

  describe 'GET /show' do
    it 'renders a successful response' do
      response = get api_v1_user_path(user.id)
      expect(response).to eq(302)
    end
  end

  describe 'POST /create' do
    context 'with valid parameters' do
      params = { first_name: 'jhon1', last_name: 'petter1', email: 'john.pette1r@gmail.com', address: 'USA' }
      it 'creates a new User' do
        expect { post api_v1_users_path, params: params }.to change(User, :count).by(1)
      end
    end

    context 'with invaild params' do
      params = { first_name: 'jhon1', last_name: 'petter1', email: nil, address: 'California, USA' }
      it 'creates a new User' do
        expect do
          post api_v1_users_path, params: params
        end.to change(User, :count).by(0)
      end
    end
  end

  describe 'PATCH update' do
    context 'with valid parameters' do
      let!(:user1) { User.create(attributes) }
      it 'updates the requested user' do
        patch api_v1_user_path(user1.id), params: { first_name: 'abdul' }
        expect(user1.reload.first_name).to eq('abdul')
      end
    end

    context 'with unvalid parameters' do
      let(:unvalid_params) { { email: nil } }
      let!(:user1) { User.create(attributes) }
      it 'updates the requested user' do
        patch api_v1_user_path(user1.id), params: unvalid_params
        expect(JSON.parse(response.body)['message']).to eq ["Email can't be blank", "Email is invalid"]
      end
    end
  end

  describe 'DELETE destroy' do
    it 'destroys the requested user' do
      user = User.create(attributes)
      expect {
        delete api_v1_user_path(user)
      }.to change(User, :count).by(-1)
    end
  end
end
