require 'rails_helper'

RSpec.describe Booking, type: :model do
  before do
    @user = FactoryBot.create(:user)
    @travel = FactoryBot.create(:travel)
  end
  describe "Booking model functions" do
    context 'If travel is empty' do
      it "Validation fails" do
        booking = Booking.create(travel_id: "", confirmation: "ABCDEF")
        expect(booking).to be_invalid
      end
    end
    context 'If confirmation is empty' do
      it "Validation fails" do
        booking = Booking.create(travel_id: @travel.id, confirmation: "")
        expect(booking).to be_invalid
      end
    end
    context 'If all contain value' do
      it "Validation fails" do
        booking = Booking.create(travel_id: @travel.id, confirmation: "ABCDEF")
        expect(booking).to be_valid
      end
    end
  end
end
