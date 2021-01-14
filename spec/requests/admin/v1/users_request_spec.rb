require 'rails_helper'

RSpec.describe "Admin::V1::Users", type: :request do
  let(:user) { create(:user) }

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
end
