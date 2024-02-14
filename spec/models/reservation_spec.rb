require 'rails_helper'

RSpec.describe Reservation, type: :model do
  describe 'associations' do
    it { should belong_to(:user) }
    it { should belong_to(:schedule) }
  end

  describe 'validations' do
    it { should validate_presence_of(:schedule_id) }
    it { should validate_presence_of(:user_id) }
  end
end
