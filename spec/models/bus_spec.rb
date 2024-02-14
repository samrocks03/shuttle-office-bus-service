require 'rails_helper'

RSpec.describe Bus, type: :model do
  let(:bus) { build(:bus) }

  describe 'validations' do
    it { should validate_presence_of(:capacity) }
    it { should validate_presence_of(:model) }
  end

  describe 'associations' do
    it { should have_many(:schedules).dependent(:destroy) }
    it { should belong_to(:company) }
  end

  describe 'callbacks' do
    describe 'before_validation' do
      describe '#normalize_model' do
        it 'downcases and titleizes the model' do
          bus = Bus.new(model: 'Some Model')
          bus.validate
          expect(bus.model).to eq('Some Model')
        end

        it 'downcases and titleizes the number' do
          bus = Bus.new(number: 'AB123')
          bus.validate
          expect(bus.number).to eq('Ab123')
        end
      end
    end
  end
end
