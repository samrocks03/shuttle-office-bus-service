
require 'rails_helper'

RSpec.describe BusesController, type: :controller do

  before(:each) do
    seed_data
    user = create(:user, role_id: 2)
    add_request_headers(user)
  end

  # -------------------------- index ------------------------------

  describe 'GET #index' do

    it 'returns a success response' do
      get :index
      expect(response).to be_successful
    end
  end

  # -------------------------- show ------------------------------

  describe 'GET #show' do

    let(:bus) { create(:bus) }

    it 'returns a success response' do
      get :show, params: { id: bus.id }
      expect(response).to be_successful
    end
  end

  # -------------------------- post ------------------------------

  describe 'POST #create' do
    context 'with valid parameters' do

      let(:company) {create(:company) }
      let(:valid_params) do
        { bus: { number: '123', capacity: 50, model: 'XYZ', company_id: company.id } }
      end

      it 'creates a new bus' do
        expect {
          post :create, params: valid_params
        }.to change(Bus, :count).by(1)
      end

      it 'returns the created bus' do
        post :create, params: valid_params
        expect(response).to have_http_status(:created)
        # byebug
        expect(response.body).to eq(Bus.last.as_json.to_json)
      end
    end

    context 'with invalid parameters' do
      let(:invalid_params) do
        {
          bus: {
            number: '',
            capacity: 50,
            model: 'XYZ',
            company_id: 1
          }
        }
      end

      it 'does not create a new bus' do
        expect {
          post :create, params: invalid_params
        }.not_to change(Bus, :count)
      end

      it 'returns the error messages' do
        post :create, params: invalid_params
        expect(response).to have_http_status(:unprocessable_entity)
        expect(JSON.parse(response.body)).to include('Company must exist')
      end
    end
  end


  # -------------------------- put ------------------------------
  describe 'PUT #update' do
    before(:each) do
      @bus = create(:bus)
    end

    context 'with valid parameters' do

      it 'updates the requested bus' do
        put :update, params: { id: @bus.id, model: @bus.model, number: "123", capacity: @bus.company_id, company_id: @bus.company_id}

        expect(response).to be_successful
        expect(@bus.reload.number).to eq("123")
      end
    end

    context 'with invalid parameters' do
      let(:invalid_attributes) do
        {
          number: '',
          capacity: 50,
          model: 'XYZ',
          company_id: 1
        }
      end
    end
  end

  describe 'DELETE #destroy' do
    before(:each) do
      @bus = create(:bus)
    end

    it 'destroys the bus' do
      expect {
        delete :destroy, params: { id: @bus.id }
      }.to change(Bus, :count).by(-1)
    end

    it 'returns a success message' do
      delete :destroy, params: { id: @bus.id }
      expect(response).to have_http_status(:ok)
    end
  end
end
