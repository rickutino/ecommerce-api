require 'rails_helper'

RSpec.describe "Admin V1 Users without authenticated", type: :request do
    context "GET /users" do
      let(:url) { "/admin/v1/users/" } 
      let!(:users) { create_list(:user, 5) }

      before(:each) { get url }
      include_examples "unauthenticated access"
    end

    context "POST /Users" do
      let(:url) { "/admin/v1/users/" }

      before(:each) { post url }
      include_examples "unauthenticated access"
    end

    context "PATCH /Users/:id" do
      let(:user_test) { create(:user) }
      let(:url) { "/admin/v1/users/#{user_test.id}" }

      before(:each) { patch url }
      include_examples "unauthenticated access"
    end

    context "DELETE /Users/:id" do
      let(:user_test) { create(:user) }
      let(:url) { "/admin/v1/users/#{user_test.id}" }

      before(:each) { delete url }
      include_examples "unauthenticated access"
    end
end