require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:first_name) }
    it { should validate_presence_of(:last_name) }
    it { should validate_presence_of(:phone_number) }
    it { should validate_presence_of(:password_digest) }
    it { should validate_numericality_of(:phone_number) }
    it { should allow_value('1234567890').for(:phone_number) }
    it { should_not allow_value('123').for(:phone_number).with_message('must be 10 digits') }

    # Use shoulda-matchers for uniqueness validation
    # it { should validate_uniqueness_of(:email).case_insensitive }
    # it { should validate_uniqueness_of(:phone_number) }

    it { should allow_value('test@example.com').for(:email) }
    it { should_not allow_value('invalid_email').for(:email).with_message('is not looking good') }
  end
end
