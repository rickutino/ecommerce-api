require 'rails_helper'

RSpec.describe "Admin::V1::Users ad Admin", type: :request do
  let!(:user) { create(:user) }

  describe "GET /admin/v1/users" do
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

  describe "POST /admin/v1/users" do
    let(:url) { "/admin/v1/users" }

    context "with valid params" do
      let!(:user_params) { { user: attributes_for(:user) }.to_json }

      it "should create a new User" do
        expect do
          post url, headers: auth_header(user), params: user_params
        end.to change(User, :count).by(1)
      end
      it "returns last added user" do
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
      let!(:new_invalid_name) { nil }
      let!(:invalid_user_params) do
        { user: attributes_for(:user, name: new_invalid_name) }.to_json
      end

      it "should does not add a new User" do
        expect do
          post url, headers: auth_header(user), params: invalid_user_params
        end.to_not change(User, :count)
      end

      it "returns errors messages" do
        post url, headers: auth_header(user), params: invalid_user_params
        expect(body_json['errors']['fields']).to have_key('name')
      end

      it "returns unprocessable_entity status" do
        post url, headers: auth_header(user), params: invalid_user_params
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
  
  describe "PATCH /admin/v1/users/:id" do
    let!(:user_test) { create(:user) }
    let(:url) { "/admin/v1/users/#{user_test.id}"}

    context "with valid params" do
      let(:new_name) { "Ricardo" }
      let!(:user_params) { { user: { name: new_name } }.to_json }

      it "updates User" do
        patch url, headers: auth_header(user), params: user_params
        user_test.reload
        expect(user_test.name).to eq new_name
      end

      it "returns update User" do
        patch url, headers: auth_header(user), params: user_params
        user_test.reload
        expected_user = user_test.as_json( only: %i(id name email profile) )
        expect(body_json['user']).to eq expected_user
      end

      it "returns apdated status" do
        patch url, headers: auth_header(user), params: user_params
        expect(response).to have_http_status(:ok)
      end
    end
    context "with invalid params" do
      let!(:new_invalid_name) { nil }
      let(:user_invalid_params) do
        { user: attributes_for(:user, name: new_invalid_name) }.to_json
      end 

      it "should does not apdate User" do
        old_name = user_test.name
        patch url, headers: auth_header(user), params: user_invalid_params
        user_test.reload
        expect(user_test.name).to eq old_name
      end

      it "returns message errors" do
        patch url, headers: auth_header(user), params: user_invalid_params
        user_test.reload
        expect(body_json['errors']['fields']).to have_key('name')
      end

      it "returns unprocessable_entity status" do
        patch url, headers: auth_header(user), params: user_invalid_params
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "DELETE /admin/v1/users/:id" do
    let!(:user_test) { create(:user) }
    let(:url) { "/admin/v1/users/#{user_test.id}"}

    it "should removes user" do
      expect do
        delete url, headers: auth_header(user)
      end.to change(User, :count).by(-1)
    end

    it "returns no_content status" do
      delete url, headers: auth_header(user)
      expect(response).to have_http_status(:no_content)
    end

    it "should does not return any body content" do
      delete url, headers: auth_header(user)
      expect(body_json).to_not be_present
    end
  end
end
