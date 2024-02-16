require 'rails_helper'

RSpec.describe Company, type: :model do
  it "is valid with valid attributes" do
    company = build(:company)
    expect(company).to be_valid
  end

  it "is not valid without a name" do
    company = build(:company, name: nil)
    expect(company).to_not be_valid
  end

  it "is not valid without a location" do
    company = build(:company, location: nil)
    expect(company).to_not be_valid
  end

  it "normalizes name and location before validation" do
    company = build(:company, name: "someName", location: "someLocation")
    company.valid?
    expect(company.name).to eq("Somename")
    expect(company.location).to eq("Somelocation")
  end

  describe "associations" do
    it { should have_many(:users).dependent(:destroy) }
    it { should have_many(:buses).dependent(:destroy) }
    # Uncomment the line below if you add the has_one association
    # it { should have_one(:schedule).dependent(:destroy) }
  end
end
