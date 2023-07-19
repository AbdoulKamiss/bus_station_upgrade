require 'rails_helper'

RSpec.describe "Travels", type: :system do
  describe 'Travels CRUD functions' do
    before do
      @admin = FactoryBot.create(:user, name: 'admin', email: 'admin@example.com', password: 'password', password_confirmation: 'password', admin: true, confirmed_at: DateTime.now)
      @user = FactoryBot.create(:user, confirmed_at: DateTime.now)
    end
    context 'When a user tries to create a travel' do
      it 'will not work' do
        visit new_user_session_path
        fill_in 'Email', with: @user.email
        fill_in 'Password', with: @user.password
        click_on 'Log in'
        visit new_travel_path
        expect(current_path).to eq root_path
      end
    end
    context 'When an admin tries to create a travel' do
      before do
        @station1 = FactoryBot.create(:station1)
        @station2 = FactoryBot.create(:station2)
      end
      it 'will work' do
        visit new_user_session_path
        fill_in 'Email', with: @admin.email
        fill_in 'Password', with: @admin.password
        click_on 'Log in'
        click_on 'Add-Travels'
        fill_in 'Date', with: '2023-08-05'
        fill_in 'Time', with: '09:00:00'
        fill_in 'Duration', with: '200'
        select(@station1.name, from: 'Starting station')
        select(@station2.name, from: 'Destination station')
        click_on 'Create Travel'
        expect(page).to have_content 'Travel was successfully created.'
      end
    end
    context 'When an admin tries to edit a travel' do
      before do
        @travel = FactoryBot.create(:travel)
      end
      it 'will work' do
        visit new_user_session_path
        fill_in 'Email', with: @admin.email
        fill_in 'Password', with: @admin.password
        click_on 'Log in'
        visit travel_path(@travel.id)
        click_on 'Edit'
        fill_in 'Duration', with: '500'
        click_on 'Update'
        expect(page).to have_content 'Travel was successfully updated.'
      end
    end
    context 'When an admin tries to destroy a travel' do
      before do
        @travel = FactoryBot.create(:travel)
      end
      it 'will work' do
        visit new_user_session_path
        fill_in 'Email', with: @admin.email
        fill_in 'Password', with: @admin.password
        click_on 'Log in'
        sleep(5)
        visit travel_path(@travel.id)
        sleep(5)
        click_on 'Delete'
        page.accept_confirm
        expect(page).to have_content 'Travel was successfully destroyed.'
      end
    end
  end
end
