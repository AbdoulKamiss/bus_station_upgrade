require 'rails_helper'

RSpec.describe Travel, type: :model do
  before do
    @station1 = FactoryBot.create(:station1)
    @station2 = FactoryBot.create(:station2)
  end
  describe 'Travel model functions' do
    context 'If date is empty' do
      it 'Validation fails' do
        travel = Travel.create(date: "", time: Time.now, duration: "120", starting_station_id: @station1.id, destination_station_id: @station2.id)
        expect(travel).to be_invalid
      end
    end
    context 'If time is empty' do
      it 'Validation fails' do
        travel = Travel.new(date: Date.today, time: "", duration: "120", starting_station_id: @station1.id, destination_station_id: @station2.id)
        expect(travel).to be_invalid
      end
    end
    context 'If duration is empty' do
      it 'Validation fails' do
        travel = Travel.create(date: Date.today, time: Time.now, duration: "", starting_station_id: @station1.id, destination_station_id: @station2.id)
        expect(travel).to be_invalid
      end
    end
    context 'If starting_station is empty' do
      it 'Validation fails' do
        travel = Travel.create(date: Date.today, time: Time.now, duration: "120", starting_station_id: "", destination_station_id: @station2.id)
        expect(travel).to be_invalid
      end
    end
    context 'If destination_station is empty' do
      it 'Validation fails' do
        travel = Travel.create(date: Date.today, time: Time.now, duration: "120", starting_station_id: @station1.id, destination_station_id: "")
        expect(travel).to be_invalid
      end
    end
    context 'If starting_station and destination_station are the same' do
      it 'Validation fails' do
        travel = Travel.create(date: Date.today, time: Time.now, duration: "120", starting_station_id: @station1.id, destination_station_id: @station1.id)
        expect(travel).to be_invalid
      end
    end
    context 'If all contain value' do
      it 'Validation succeds' do
        travel = Travel.create(date: Date.today, time: Time.now, duration: "120", starting_station_id: @station1.id, destination_station_id: @station2.id)
        expect(travel).to be_valid
      end
    end
  end 
end
