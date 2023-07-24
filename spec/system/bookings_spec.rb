require 'rails_helper'

RSpec.describe "Bookings", type: :system do
  describe 'Bookings CRUD functions' do
    before do
      @user = FactoryBot.create(:user, confirmed_at: DateTime.now)
      @travel = FactoryBot.create(:travel)
    end
    context 'When a user tries to book a travel' do
      it 'will work' do
        visit new_user_session_path
        fill_in 'Email', with: @user.email
        fill_in 'Mot de passe', with: @user.password
        click_on 'Se connecter'
        visit travel_path(@travel)
        click_on 'Réserver'
        click_on 'Confirmer'
        expect(page).to have_content 'Le voyage a été réserver avec succès.'
      end
    end
    context 'When a user tries to cancel his travel' do
      it 'will work' do
        visit new_user_session_path
        fill_in 'Email', with: @user.email
        fill_in 'Mot de passe', with: @user.password
        click_on 'Se connecter'
        visit travel_path(@travel)
        click_on 'Réserver'
        click_on 'Confirmer'
        click_on 'Annuler'
        page.accept_confirm
        expect(page).to have_content 'La réservation a été annuler avec succès.'
      end
    end
  end
end
