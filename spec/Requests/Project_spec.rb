# Coding: UTF-8
require 'spec_helper'

feature 'the Dashboard' do
	include Rails.application.routes.url_helpers

	let!(:user) {User.new email: 'a@b.de', password: 'veryright',password_confirmation: 'veryright', firstname: 'Peter', lastname: 'Zwegert'}
	let!(:project) {Project.new name: 'Test1'}
	let!(:project2) {Project.new name: 'Test2'}
	let!(:project3) {Project.new name: 'Test3'}
	let!(:project4) {Project.new name: 'Test4'}
	let!(:list1){List.new name: 'testlist1'}
	let!(:list2){List.new name: 'testlist2'}
	let!(:list3){List.new name: 'testlist3'}
	let!(:task1){Task.new titel: 'testtask1',priority:'low'}
	let!(:task2){Task.new titel: 'testtask2',priority:'high'}
	let!(:task3){Task.new titel: 'testtask3',priority:'high'}

	before (:each) do
		user.save!
		list1.tasks << task1
		list2.tasks << task2
		list3.tasks << task3
		project4.lists << list3
		project3.lists << list1
		project3.lists << list2
		project2.save!
		project3.save!
		project4.save!
		TasksUsers.assignUserToTask(task1.id,user.id)
		ProjectsUsers.addUserToProject(project2.id,user.id,'author')
		ProjectsUsers.addUserToProject(project3.id,user.id,'member')
		visit root_path
		click_link 'Anmelden'
		fill_in 'E-Mail', with: user.email
		fill_in 'Passwort', with: user.password
		click_button 'Anmelden'
		page.should have_content 'Dashboard'
	end

	it 'Allows a user to show all projects he belongs to' do
		click_link 'Projekte ansehen'
		page.should have_content 'Meine Projekte'
		page.should have_content project2.name
		page.should have_content project3.name
	end

	it 'Allows a user to show all task he is advised to do' do
		click_on('Aufgaben erledigen')
		page.should have_content 'Übersicht'
		page.should have_content task1.titel
		page.should_not have_content task2.titel
	end

	it 'Allows a user to show all tasks withoud users assigned to them from Projects he belongs to' do
		click_on('Aufgaben zuweisen')
		page.should have_content task2.titel
		page.should_not have_content task1.titel
		page.should_not have_content task3.titel
	end

	it 'Allows a user to show all Task with high priority in projects he belongs to' do
		click_on("Dringendes erledigen")
		page.should have_content task2.titel
		page.should_not have_content task3.titel
	end

	it 'Allows users to creat a project' do
		click_link 'Projekte ansehen'
		page.should have_content 'Meine Projekte'
		click_link 'Neues Projekt erstellen'
		page.should have_content 'Neues Projekt anlegen'
		fill_in 'Projektname', with: project.name
		click_button 'Anlegen'
		page.should have_content project.name
		page.should have_content 'Organisation'
		click_link 'Zur Projektübersicht'
		page.should have_content project.name
	end

	it 'Allows users to delete a project' do
		click_link 'Projekte ansehen'
		page.should have_content project2.name
		click_link project2.name
		page.should	have_content 'Organisation'
		click_link 'Projekt löschen'
		page.should_not have_content project2.name
		page.should have_content project3.name
	
	end

	it 'Does not allow a user to delete a project not belonging to him/her' do
		click_link 'Projekte ansehen'
		page.should have_content project3.name
		click_link project3.name
		page.should	have_content 'Organisation'
		click_link 'Projekt löschen'
		page.should have_content 'Für diesen Vorgang haben Sie keine Berechtigung.'
	end

	it 'Allows a user to delete/create a list in a project' do
		click_link 'Projekte ansehen'
		page.should have_content project2.name
		click_link project2.name
		page.should have_content 'Organisation'
		click_link 'Neue Liste anlegen...'
		page.should have_content 'neue Liste'
		click_on ('Liste löschen')
		page.should_not have_content 'neue Liste'
	end

	it 'Allows a user to create/delete a task' do
		click_link 'Projekte ansehen'
		page.should have_content project2.name
		click_link project2.name
		page.should have_content 'Organisation'
		click_link 'Neue Liste anlegen...'
		page.should have_content 'neue Liste'
		click_link 'Aufgabe anlegen'
		page.should have_content 'neue Aufgabe'
		first(:link, '×').click
		page.should_not have_content 'neue Aufgabe'

	end

#	it 'Allows a user to rename a list' 
#		click_link 'Projekte ansehen'
#		page.should have_content project2.name
#		click_link project2.name
#		page.should have_content 'Organisation'
#		click_link 'Neue Liste anlegen...'
#		page.should have_content 'neue Liste'
#		page.find(".list-title").click
#		print page.html
#		fill_in 'Listname', with: 'testtest'
#		page.should have_content 'testtest'
#	end

#	it 'Allows a user to rework a task'do
#		click_link 'Projekte ansehen'
#		page.should have_content project2.name
#		click_link project2.name
#		page.should have_content 'Organisation'
#		click_link 'Neue Liste anlegen...'
#		page.should have_content 'neue Liste'
#		click_on('Aufgabe anlegen')
#		page.should have_content 'neue Aufgabe'
#		page.find(".task_modal").click
#		fill_in 'title', with:'testtest'
#		click_on('Speichern')
#		page.should have_content 'testtest'
#	end

 	


end