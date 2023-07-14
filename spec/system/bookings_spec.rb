require 'rails_helper'

RSpec.describe "Bookings", type: :system do
  describe 'Bookings CRUD functions' do
    before do
      @user = FactoryBot.create(:user, confirmed_at: DateTime.now)
    end
    context 'When a user tries to book a travel' do
      it 'will work' do
        visit new_user_session_path
        fill_in 'Email', with: @user.email
        fill_in 'Password', with: @user.password
        click_on 'Log in'
        visit travels_path
        click_on 'Book Travel'
        click_on 'Confirm'
        expect(page).to have_content 'Travel successfully booked!'
      end
    end
    context 'When a user tries to cancel his travel' do
      it 'will work' do
        visit new_user_session_path
        fill_in 'Email', with: @user.email
        fill_in 'Password', with: @user.password
        click_on 'Log in'
        visit travels_path
        click_on 'Book Travel'
        click_on 'Confirm'
        expect(page).to have_content 'Travel successfully booked!'
        click_on 'Cancel'
        page.accept_confirm
        expect(page).to have_content 'Booking was successfully canceled.'
      end
    end
  end
end
