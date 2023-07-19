require 'rails_helper'

RSpec.describe "Users", type: :system do
  describe 'Registration function' do
    context 'when a user create an account' do
      it 'redirect to root path' do
        visit new_user_registration_path
        fill_in 'Name', with: 'John'
        fill_in 'Email', with: 'john@gmail.com'
        fill_in 'Password', with: '123456'
        fill_in 'Password confirmation', with: '123456'
        click_on 'Sign up'
        expect(page).to have_content 'A message with a confirmation link has been sent to your email address. Please follow the link to activate your account.'
      end
    end
    context 'when a user tries to edit his profile' do
      before do
        @user = FactoryBot.create(:user, confirmed_at: DateTime.now)
      end
      it 'will work' do
        visit new_user_session_path
        fill_in 'Email', with: @user.email
        fill_in 'Password', with: @user.password
        click_on 'Log in'
        click_on 'My Profile'
        click_on 'Edit my profile'
        fill_in 'Name', with: 'Johnny'
        fill_in 'Current password', with: '123456'
        click_on 'Update'
        expect(page).to have_content 'Your account has been updated successfully.'
        click_on 'My Profile'
        expect(page).to have_content 'Profile of Johnny'
      end
    end
    context 'when a user cancel his account' do
      before do
        @user = FactoryBot.create(:user, confirmed_at: DateTime.now)
      end
      it 'will work and redirect to root path' do
        visit new_user_session_path
        fill_in 'Email', with: 'john@gmail.com'
        fill_in 'Password', with: '123456'
        click_on 'Log in'
        click_on 'My Profile'
        click_on 'Edit my profile'
        click_on 'Cancel my account'
        page.accept_confirm
        expect(page).to have_content 'Bye! Your account has been successfully cancelled. We hope to see you again soon.'
      end
    end
  end
  describe 'Login function' do
    context 'when non logged-in user try to access to travel page' do
      before do
        @user = FactoryBot.create(:user, confirmed_at: DateTime.now)
      end
      it 'is rejected and redirect to login page' do
        visit travels_path
        expect(page).to have_content 'Log in'
      end
    end
    context 'when a existing user log in and log out' do
      before do
        @user = FactoryBot.create(:user, confirmed_at: DateTime.now)
      end
      it 'is successfully working' do
        visit new_user_session_path
        fill_in 'Email', with: 'john@gmail.com'
        fill_in 'Password', with: '123456'
        click_on 'Log in'
        expect(page).to have_content 'Signed in successfully'
        click_on 'Logout'
        expect(page).to have_content 'Signed out successfully'
      end
    end
  end
  describe 'User access restriction' do
    context 'when user tries to access admin page' do
      before do
        @admin = FactoryBot.create(:user, name: 'admin', email: 'admin@example.com', password: 'password', password_confirmation: 'password', admin: true, confirmed_at: DateTime.now)
        @user = FactoryBot.create(:user, confirmed_at: DateTime.now)
      end
      it 'only admin user is able to access to admin dashboard' do
        visit new_user_session_path
        fill_in 'Email', with: 'john@gmail.com'
        fill_in 'Password', with: '123456'
        click_on 'Log in'
        expect(page).not_to have_content 'Admin Dashbord'
        click_on 'Logout'
        click_on 'Login'
        fill_in 'Email', with: 'admin@example.com'
        fill_in 'Password', with: 'password'
        click_on 'Log in'
        expect(page).not_to have_content 'Admin Dashbord'
      end
    end
  end
end