# spec/controllers/users_controller_spec.rb
require 'rails_helper'


RSpec.describe UsersController, type: :controller do
  before(:each) do
    seed_data
  end

  describe 'GET index' do
    before(:each) do
      user = create(:user, role_id: 2)
      add_request_headers(user)
    end

    it "returns a success response" do
      get :index
      expect(response).to be_successful
    end
  end


  describe "GET show" do
    before(:each) do
      @user = create(:user, role_id: 2)
      add_request_headers(@user)
      # user = create(:user, role_id: 2)
    end

    it "returns a success response" do
      get :show, params: {id: @user.id}
      expect(response).to be_successful
    end
  end


  describe 'POST #login' do
    let!(:user) { create(:user) }
    let(:valid_credentials) { { email: user.email, password: user.password } }

    context 'with valid credentials' do
      it 'returns a JWT token' do
        post :login, params: { user: valid_credentials }
        expect(response).to have_http_status(:accepted)
        expect(response.body).to include('token')
      end
    end

    context 'with invalid credentials' do
      let(:invalid_credentials) { { email: user.email, password: 'invalid_password' } }

      it 'returns an unauthorized status' do
        post :login, params: { user: invalid_credentials }
        expect(response).to have_http_status(:unauthorized)
        expect(response.body).to include('Invalid password')
      end
    end
  end


  describe 'POST #create' do

    context 'with valid attributes' do
      let(:valid_attributes) { attributes_for(:user) }

      it 'creates a new user' do
        expect {
          post :create, params: { user: valid_attributes }
        }.to change(User, :count).by(1)
      end

      it 'returns a JWT token' do
        post :create, params: { user: valid_attributes }
        expect(response).to have_http_status(:created)
        expect(response.body).to include('token')
      end
    end

    context 'with invalid attributes' do
      let(:invalid_attributes) { attributes_for(:user, email: nil) }

      it 'does not create a new user' do
        expect {
          post :create, params: { user: invalid_attributes }
        }.not_to change(User, :count)
      end

      it 'returns unprocessable_entity status' do
        post :create, params: { user: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "PUT #update" do
    before(:each) do
      @user = create(:user, role_id: 2)
      add_request_headers(@user)
    end

    it "updates the requested user" do
      put :update, params: {id: @user.id, first_name: "asdfg", last_name: @user.last_name, email: @user.email, password: @user.password}

      expect(response).to be_successful
      expect(@user.reload.first_name).to eq("Asdfg")
    end

    it "error for the requested user" do
      put :update, params: {id: @user.id, first_name: "asdfg", last_name: @user.last_name, email: "", password: @user.password}
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  describe "DELETE #destroy" do
    before(:each) do
      @user = create(:user, role_id: 2)
      add_request_headers(@user)
    end

    it "destroys the requested user" do
      expect {
        delete :destroy, params: {id: @user.id}
      }.to change(User, :count).by(-1)
    end

    it "returns a 204 No Content response" do
      delete :destroy, params: {id: @user.id}
      expect(response).to have_http_status(:ok)
    end
  end

end
