require 'rails_helper'

RSpec.describe Schedule, type: :model do
  describe "validations" do
    it "is valid with valid attributes" do
      schedule = build(:schedule) # Assuming you have a factory for Schedule
      expect(schedule).to be_valid
    end

    it "is not valid without start_point" do
      schedule = build(:schedule, start_point: nil)
      expect(schedule).to_not be_valid
    end

    it "is not valid without arrival_time" do
      schedule = build(:schedule, arrival_time: nil)
      expect(schedule).to_not be_valid
    end

    it "is not valid without departure_time" do
      schedule = build(:schedule, departure_time: nil)
      expect(schedule).to_not be_valid
    end

    it "is not valid if arrival_time is less than departure_time" do
      schedule = build(:schedule, arrival_time: Time.now, departure_time: Time.now + 1.hour)
      expect(schedule).to_not be_valid
    end

    it "is valid with unique schedule within duration" do
      bus = create(:bus)
      schedule1 = create(:schedule, bus: bus, date: Date.today, departure_time: Time.now, arrival_time: Time.now + 2.hours)
      schedule2 = build(:schedule, bus: bus, date: Date.today, departure_time: Time.now + 3.hours, arrival_time: Time.now + 4.hours)
      expect(schedule2).to be_valid
    end

    it "is not valid with overlapping schedules" do
      bus = create(:bus)
      schedule1 = create(:schedule, bus: bus, date: Date.today, departure_time: Time.now, arrival_time: Time.now + 2.hours)
      schedule2 = build(:schedule, bus: bus, date: Date.today, departure_time: Time.now + 1.hour, arrival_time: Time.now + 3.hours)
      expect(schedule2).to_not be_valid
    end
  end

  describe "associations" do
    it { should belong_to(:bus) }
    it { should have_many(:reservations).dependent(:destroy) }
  end

  describe "callbacks" do
    it "sets default available_seats" do
      company = create(:company) # Create a company instance first
      bus = create(:bus, company: company, capacity: 50) # Associate the bus with the company
      schedule = create(:schedule, bus: bus)
      expect(schedule.available_seats).to eq(50)
    end
  end

  describe "methods" do
    let(:bus) { create(:bus, capacity: 50) }
    let(:schedule) { create(:schedule, bus: bus, available_seats: 10) }

    it "decrements available_seats" do
      schedule.decrement_available_seat
      expect(schedule.available_seats).to eq(9)
    end

    it "increments available_seats" do
      schedule.increment_available_seat
      expect(schedule.available_seats).to eq(11)
    end
  end
end
