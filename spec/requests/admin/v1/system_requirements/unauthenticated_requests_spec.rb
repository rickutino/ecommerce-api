require 'rails_helper'

RSpec.describe "Admin V1 System_requirements without authenticated", type: :request do
    context "GET /System_requirements" do
      let(:url) { "/admin/v1/system_requirements/" } 
      let!(:system_requirements) { create_list(:system_requirement, 5) }

      before(:each) { get url }
      include_examples "unauthenticated access"
    end

    context "POST /System_requirements" do
      let(:url) { "/admin/v1/system_requirements/" }

      before(:each) { post url }
      include_examples "unauthenticated access"
    end

    context "PATCH /System_requirements/:id" do
      let(:system_requirement) { create(:system_requirement) }
      let(:url) { "/admin/v1/system_requirements/#{system_requirement.id}" }

      before(:each) { patch url }
      include_examples "unauthenticated access"
    end

    context "DELETE /System_requirements/:id" do
      let(:system_requirement) { create(:system_requirement) }
      let(:url) { "/admin/v1/system_requirements/#{system_requirement.id}" }

      before(:each) { delete url }
      include_examples "unauthenticated access"
    end
end