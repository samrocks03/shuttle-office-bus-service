# spec/acceptance/company_spec.rb

# require 'rails_helper'
# require 'rspec_api_documentation/dsl'

# spec/acceptance/companies_spec.rb

require 'rails_helper'
require 'rspec_api_documentation/dsl'

RSpec.describe 'Companies API', type: :request do
  resource 'Companies' do
    explanation 'API for managing companies'

    header 'Content-Type', 'application/json'
    header 'Authorization', :authorization_header

    let(:user) { create(:user, role_id: 2) } # Create a user with admin role for authorization
    let(:authorization_header) { 'Bearer ' + JWT.encode({user_id: user.id}, Rails.application.credentials[:secret_key_base]) }

    before(:each) do
      seed_data
    end

    get '/companies' do
      example 'Listing companies' do
        do_request
        expect(status).to eq(200)
      end
    end
    

    post '/companies' do
      parameter :name, 'Name of the company', required: true
      parameter :location, 'Location of the company', required: true

      let(:raw_post) { { name: 'New Company', location: 'New Location' }.to_json }

      example 'Creating a company' do
        do_request
        expect(status).to eq(201)
      end
    end

    # post '/companies' do
    #   parameter :name, 'Name of the company', required: true
    #   parameter :location, 'Location of the company', required: true

    #   let(:name) { 'New Company' }
    #   let(:location) { 'New Location' }

    #   example 'Creating a company' do
    #     do_request
    #     expect(status).to eq(201)
    #   end
    # end

  end
end



# require 'rails_helper'
# require 'rspec_api_documentation/dsl'

# resource "Companies" do
#   # before(:each) do
#   #   seed_data
#   #   user = create(:user, role_id: 2)
#   #   # add_request_headers(user)
#   # end

#   get "/companies" do
#     example "not listing companies" do
#       do_request
#       expect(status).to eq(401)
#     end
#   end
# end

# resource "Companies" do
#   explanation "Companies are the entities that provide bus services."

#   header "Content-Type", "application/json"
#   before(:each) do
#     seed_data
#     user = create(:user, role_id: 2)
#     add_request_headers(user)
#   end


#   get "/companies" do
#     example "Listing companies" do
#       do_request
#       expect(status).to eq(200)
#     end
#   end
  # post "/companies" do
  #   with_options scope: :company, required: true do
  #     parameter :name, "Name of the company"
  #     parameter :address, "Address of the company"
  #     parameter :phone, "Phone number of the company"
  #     parameter :email, "Email of the company"
  #   end

  #   let(:name) { "ABC Bus Company" }
  #   let(:address) { "123 Main St, Springfield, IL 62701" }
  #   let(:phone) { "217-555-1212" }
  #   let(:email) { "abc@busco.com" }
  #   example "Creating a company" do
  #     do_request
# end
