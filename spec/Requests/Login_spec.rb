# Coding: UTF-8
require 'spec_helper'



feature 'The Home Page' do
	include Rails.application.routes.url_helpers

	let!(:user) {User.new email: 'a@b.de', password: 'veryright',password_confirmation: 'veryright', firstname: 'Peter', lastname: 'Zwegert'}
		
	

	it 'Does not point to Dashboard if wrong login' do
		visit root_path
		click_link 'Anmelden'
		fill_in 'E-Mail', with: user.email
		fill_in 'Passwort', with: 'wrong'
		click_button 'Anmelden'
		page.should have_content 'Wir konnten diesen Benutzer nicht finden.' 
		end

	it 'Does point to the Dashboard if correct login' do
		user.save!
		visit root_path	
		click_link 'Anmelden'
		fill_in 'E-Mail', with: user.email
		fill_in 'Passwort', with: user.password
		click_button 'Anmelden'
		page.should have_content 'Dashboard'
	end

	it 'Lets a user logout'do
		user.save!
		visit root_path	
		click_link 'Anmelden'
		fill_in 'E-Mail', with: user.email
		fill_in 'Passwort', with: user.password
		click_button 'Anmelden'
		page.should have_content 'Dashboard'
		click_link 'Abmelden'
		page.should have_content 'Sie wurden erfolgreich ausgeloggt'
	end

	it 'Lets a visitor register' do
		visit root_path
		first(:link, 'Registrieren').click
		fill_in 'E-Mail', with: user.email
		fill_in 'Vorname', with: user.firstname
		fill_in 'Nachname', with: user.lastname
		fill_in 'Passwort', with: user.password_confirmation
		fill_in 'Passwort wiederholen', with: user.password
		click_button 'Registrieren'
		page.should have_content 'Dashboard'
	end

	it 'Does not allow for a user to register twice with the same Email' do
		user.save!
		visit root_path
		first(:link, 'Registrieren').click
		fill_in 'E-Mail', with: user.email
		fill_in 'Vorname', with: user.firstname
		fill_in 'Nachname', with: user.lastname
		fill_in 'Passwort', with: user.password_confirmation
		fill_in 'Passwort wiederholen', with: user.password
		click_button 'Registrieren'
		page.should have_content 'vergeben'
	end

	it 'Does notice when password confirmation is wrong' do
		visit root_path
		first(:link, 'Registrieren').click
		fill_in 'E-Mail', with: user.email
		fill_in 'Vorname', with: user.firstname
		fill_in 'Nachname', with: user.lastname
		fill_in 'Passwort', with: 'I'
		fill_in 'Passwort wiederholen', with: user.password
		click_button 'Registrieren'
		page.should have_content 'Passwort wiederholen '
	end

	it 'does notice when E-Mail is not valid at all' do
		visit root_path
		first(:link, 'Registrieren').click
		fill_in 'E-Mail', with: 'abcdefghij'
		fill_in 'Vorname', with: user.firstname
		fill_in 'Nachname', with: user.lastname
		fill_in 'Passwort', with: user.password_confirmation
		fill_in 'Passwort wiederholen', with: user.password
		click_button 'Registrieren'
		page.should have_content 'E-mail ist nicht gültig'
	end

	it 'does not allow short passwords' do
		visit root_path
		first(:link, 'Registrieren').click
		fill_in 'E-Mail', with: user.email
		fill_in 'Vorname', with: user.firstname
		fill_in 'Nachname', with: user.lastname
		fill_in 'Passwort', with: '12345'
		fill_in 'Passwort wiederholen', with: '12345'
		click_button 'Registrieren'
		page.should have_content 'Passwort ist zu kurz'
	end

	it 'notices when either first- or lastname is missing' do
		visit root_path
		first(:link, 'Registrieren').click
		fill_in 'E-Mail', with: user.email
		fill_in 'Passwort', with: user.password
		fill_in 'Passwort wiederholen', with: user.password_confirmation
		click_button 'Registrieren'
		page.should	have_content 'Vorname muss ausgefüllt werden'
		page.should have_content 'Nachname muss ausgefüllt werden'
	end

	
end
