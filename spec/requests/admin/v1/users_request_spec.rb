require 'rails_helper'

RSpec.describe "Admin::V1::Users", type: :request do
  let!(:user) { create(:user) }

  context "GET /admin/v1/users" do
    let(:url) { "/admin/v1/users" }
    let!(:users) { create_list(:user, 5) }

    it "returns all Users" do
      get url, headers: auth_header(user)
      expect(body_json['users']).to contain_exactly *users.as_json(only: %i(id name email profile))
    end

    it "returns ok status" do
      get url, headers: auth_header(user)
      expect(response).to have_http_status(:ok)
    end
  end

  context "POST /admin/v1/users" do
    let(:url) { "/admin/v1/users" }

    context "with valida params" do
      let!("user_params") { { user: attributes_for(:user) }.to_json }

      it "adds a new User" do
        expect do
          post url, headers: auth_header(user), params: user_params
        end.to change(User, :count).by(1)
      end
      it "returns last adds user" do
        post url, headers: auth_header(user),params: user_params
        expected_user = User.last.as_json( only: %i(id name email profile) )
        expect(body_json['user']).to eq expected_user
      end
      it "returns ok status" do
        post url, headers: auth_header(user), params: user_params
        expect(response).to have_http_status(:ok)
      end
    end

    context "with invalid params" do 
      let!(:invalid_user_params) { { user: attributes_for(:user, name: nil) }.to_json }

      it "does not add a new User" do
        expect do
          post url, headers: auth_header(user), params: invalid_user_params
        end.to_not change(User, :count)
      end

      it "returns errors messages" do
        post url, headers: auth_header, params: invalid_user_params
        expect(body_json['errors']['fields']).to have_key('name')
      end

      it "returns errors messages" do
        post url, headers: auth_header, params: invalid_user_params
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
  
end
