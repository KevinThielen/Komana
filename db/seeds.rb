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
	p.lists.create(:name=>'TO DO',:position=>1)
	p.lists.create(:name=>'PENDING',:position=>2)
	p.lists.create(:name=>'FINISHED',:position=>3)
end

users.each do |e|
	ProjectsUsers.addUserToProject(projects.second.id,e.id,'member')
end

ProjectsUsers.addUserToProject(projects.second.id,dummies.first.id,'author')

ProjectsUsers.addUserToProject(projects.first.id,users.first.id,'author')
ProjectsUsers.addUserToProject(projects.third.id,users.third.id,'author')
ProjectsUsers.addUserToProject(projects.fourth.id,users.second.id,'author')

projects.first.lists.first.tasks.create(:titel=>'Find currently missing links between human and ape',:priority=> 'low',:position=>1)
projects.first.lists.first.tasks.create(:titel=>'Make fun of Lamark',:priority=> 'High',:position=>2)
projects.first.lists.first.tasks.create(:titel=>'Find way to capitalyse',:priority=> 'high',:position=>3)
projects.first.lists.second.tasks.create(:titel=>'Make everyone accept Evolution as correct',:priority=> 'medium',:position=>1)
projects.first.lists.third.tasks.create(:titel=>'Find out why there are so many Fintches on those islands',:priority=> 'low',:position=>1)
projects.first.lists.third.tasks.create(:titel=>'find a way to make everyone know',:priority=> 'low',:position=>2)


projects.second.lists.first.tasks.create(:titel=>'moderation for debate between Lamark and Thaxton',:priority=> 'medium',:position=>1)
projects.second.lists.second.tasks.create(:titel=>'moderation for debate between Darwin and Thaxton',:priority=> 'medium',:position=>1)
projects.second.lists.third.tasks.create(:titel=>'moderation for between Lamark and Darwin',:priority=> 'medium',:position=>1)



TasksUsers.assignUserToTask(projects.second.lists.first.tasks.first.id,users.first.id)
TasksUsers.assignUserToTask(projects.second.lists.second.tasks.first.id,users.second.id)
TasksUsers.assignUserToTask(projects.second.lists.third.tasks.first.id,users.third.id)

projects.third.lists.first.tasks.create(:titel=>'Find excusses for bibles contradictions',:priority=> 'medium',:position=>1)
projects.third.lists.second.tasks.create(:titel=>'Try to act less fanatikaly',:priority=> 'medium',:position=>1)
projects.third.lists.third.tasks.create(:titel=>'rework "of pandas to people"',:priority=> 'high',:position=>1)
projects.third.lists.third.tasks.create(:titel=>'find catchy name for creationism',:priority=> 'high',:position=>2)

projects.fourth.lists.second.tasks.create(:titel=>'Try not to fall into oblivion',:priority=> 'high',:position=>1)
