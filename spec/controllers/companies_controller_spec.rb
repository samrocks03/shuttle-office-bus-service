# spec/controllers/companies_controller_spec.rb
require 'rails_helper'

RSpec.describe CompaniesController, type: :controller do
  before(:each) do
    seed_data
    user = create(:user, role_id: 2)
    add_request_headers(user)
  end


  # -------------------------- index ------------------------------
  describe 'GET index' do
    it "returns a success response" do
      get :index
      expect(response).to be_successful
    end
  end

  # -------------------------- show ------------------------------s
  describe "GET show" do
    before(:each) do
      @company = create(:company)
    end

    it "returns a success response" do
      get :show, params: { id: @company.id }
      expect(response).to be_successful
    end
  end

  # -------------------------- create ------------------------------
  describe "POST #create" do
    context "with valid parameters" do
      let(:invalid_params) do
        { company: { name: "New Company" } }
      end

      it "creates a new bus" do
        expect {
          post :create, params: { name: "New Company", location: "New Location" }
      }.to change(Company, :count).by(1)
      end

      it "create a new company with invalid parameters" do
        expect {
          post :create, params: invalid_params
      }.not_to change(Company, :count)
      end
    end
  end

  # -------------------------- update ------------------------------
  describe "PUT #update" do
    before(:each) do
      @company = create(:company)
    end

    it "updates the requested company" do
      put :update, params: { id: @company.id, name: "Updated Name", location: @company.location }
      expect(response).to be_successful
      expect(@company.reload.name).to eq("Updated Name")
    end

    it "returns unprocessable_entity status for invalid attributes" do
      put :update, params: { id: @company.id, name: nil, location: @company.location }
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  # -------------------------- delete ------------------------------
  describe "DELETE #destroy" do
    before(:each) do
      @company = create(:company)
    end

    it "destroys the requested company" do
      expect {
        delete :destroy, params: { id: @company.id }
      }.to change(Company, :count).by(-1)
    end

    it "returns a 204 No Content response" do
      delete :destroy, params: { id: @company.id }
      expect(response).to have_http_status(:no_content)
    end
  end
end
