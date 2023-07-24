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
        fill_in 'Mot de passe', with: @user.password
        click_on 'Se connecter'
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
        fill_in 'Mot de passe', with: @admin.password
        click_on 'Se connecter'
        click_on 'Créer un voyage'
        fill_in 'Date', with: '2023-08-05'
        fill_in 'Heure', with: '09:00:00'
        fill_in 'Durée', with: '200'
        select(@station1.name, from: 'Départ')
        select(@station2.name, from: 'Arrivée')
        click_on 'Créer'
        expect(page).to have_content 'Le voyage a été créer avec succès.'
      end
    end
    context 'When an admin tries to edit a travel' do
      before do
        @travel = FactoryBot.create(:travel)
      end
      it 'will work' do
        visit new_user_session_path
        fill_in 'Email', with: @admin.email
        fill_in 'Mot de passe', with: @admin.password
        click_on 'Se connecter'
        sleep(3)
        visit travel_path(@travel.id)
        click_on 'Modifier'
        fill_in 'Durée', with: '500'
        click_on 'Modifier'
        expect(page).to have_content 'Le voyage a été modifier avec succès.'
      end
    end
    context 'When an admin tries to destroy a travel' do
      before do
        @travel = FactoryBot.create(:travel)
      end
      it 'will work' do
        visit new_user_session_path
        fill_in 'Email', with: @admin.email
        fill_in 'Mot de passe', with: @admin.password
        click_on 'Se connecter'
        sleep(3)
        visit travel_path(@travel.id)
        click_on 'Supprimer'
        page.accept_confirm
        expect(page).to have_content 'Le voyage a été annuler avec succès.'
      end
    end
  end
end
