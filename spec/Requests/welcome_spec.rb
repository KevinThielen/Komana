require 'spec_helper'


feature 'The Home Page' do
	include Rails.application.routes.url_helpers

	let!(:user) {User.new email: 'a@b.de', password: 'veryright',password_confirmation: 'veryright', firstname: 'Peter', lastname: 'Zwegert'}
		
	

	it 'Does not point to dashboard if wrong login' do
		visit root_path
		click_link 'Anmelden'
		fill_in 'E-Mail', with: user.email
		fill_in 'Passwort', with: 'wrong'
		click_button 'Anmelden'
		page.should have_content 'Wir konnten diesen Benutzer nicht finden.' 
		end

	it 'Does point to the dashboard if correct login' do
		user.save!
		visit root_path	
		click_link 'Anmelden'
		fill_in 'E-Mail', with: user.email
		fill_in 'Passwort', with: user.password
		click_button 'Anmelden'
		page.should have_content 'Dashboard'
	end

	it 'Lets a visitor register'do
	visit root_path
	click_link 'Registrieren'
	fill_in 'E-Mail', with: user.email
	fill_in 'Vorname', with: user.firstname
	fill_in 'Nachname', with: user.lastname
	fill_in 'Passwort', with: user.password_confirmation
	fill_in 'Passwort wiederholen', with: user.password
	click_button 'Registrieren'
	page.should have_content 'Dashboard'
	end

end
