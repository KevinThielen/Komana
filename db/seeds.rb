# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

users = User.create([{firstname:'Charles', lastname: 'Darwin', password:'Evolution', password_confirmation: 'Evolution', email: 'natural@selection.uk'},
					 {firstname:'Jean-Babtiste', lastname:'Lamark', password:'Progression', password_confirmation:'Progression', email: 'Evolutiontrough@progresss.fr'},
					 {firstname:'Charles', lastname:'Thaxton', password:'IntelligentDesign', password_confirmation:'IntelligentDesign', email: 'Clock@maker.com'}])
dummies = User.create([{firstname:'Dami', lastname:'User', password:'IntelligentDesign', password_confirmation:'IntelligentDesign', email: 'a@b'}])

projects = Project.create([{name: 'Unreval the thruth'},
						   {name: 'Debating Tour'},
						   {name:'Spread the Word of God'},
						   {name:'Coherent Theory'}])

projects.each do |p|
	p.lists.create(:name=>'TO DO')
	p.lists.create(:name=>'PENDING')
	p.lists.create(:name=>'FINISHED')
end

users.each do |e|
	ProjectsUsers.addUserToProject(projects.second.id,e.id,'member')
end

ProjectsUsers.addUserToProject(projects.second.id,dummies.first.id,'author')

ProjectsUsers.addUserToProject(projects.first.id,users.first.id,'author')
ProjectsUsers.addUserToProject(projects.third.id,users.third.id,'author')
ProjectsUsers.addUserToProject(projects.fourth.id,users.second.id,'author')

projects.first.lists.first.tasks.create(:titel=>'Find currently missing links between human and ape',:priority=> 'low')
projects.first.lists.first.tasks.create(:titel=>'Make fun of Lamark',:priority=> 'High')
projects.first.lists.first.tasks.create(:titel=>'Find way to capitalyse',:priority=> 'high')
projects.first.lists.second.tasks.create(:titel=>'Make everyone accept Evolution as correct',:priority=> 'medium')
projects.first.lists.third.tasks.create(:titel=>'Find out why there are so many Fintches on those islands',:priority=> 'low')
projects.first.lists.third.tasks.create(:titel=>'find a way to make everyone know',:priority=> 'low')


projects.second.lists.first.tasks.create(:titel=>'debate between Lamark and Thaxton',:priority=> 'medium')
projects.second.lists.second.tasks.create(:titel=>'debate between Darwin and Thaxton',:priority=> 'medium')
projects.second.lists.third.tasks.create(:titel=>'debate between Lamark and Darwin',:priority=> 'medium')



TasksUsers.assignUserToTask(projects.second.lists.first.tasks.first.id,users.second.id)
TasksUsers.assignUserToTask(projects.second.lists.first.tasks.first.id,users.third.id)
TasksUsers.assignUserToTask(projects.second.lists.second.tasks.first.id,users.first.id)
TasksUsers.assignUserToTask(projects.second.lists.second.tasks.first.id,users.third.id)
TasksUsers.assignUserToTask(projects.second.lists.third.tasks.first.id,users.third.id)
TasksUsers.assignUserToTask(projects.second.lists.third.tasks.first.id,users.second.id)

projects.third.lists.first.tasks.create(:titel=>'Find excusses for bibles contradictions',:priority=> 'medium')
projects.third.lists.second.tasks.create(:titel=>'Try to act less fanatikaly',:priority=> 'medium')
projects.third.lists.third.tasks.create(:titel=>'rework "of pandas to people"',:priority=> 'high')
projects.third.lists.third.tasks.create(:titel=>'find catchy name for creationism',:priority=> 'high')

projects.third.lists.second.tasks.create(:titel=>'Try not to fall into oblivion',:priority=> 'high')