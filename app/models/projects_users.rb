class ProjectsUsers < ActiveRecord::Base
	
	validates :role, :inclusion => { :in => %w{author member guest} }

	def self.addUserToProject(project_id, user_id)	
		if(ProjectsUsers.where(:project_id => project_id, :user_id => user_id).blank?)
			ProjectsUsers.create(:project_id => project_id, :user_id => user_id, :role => "member")
		end
	end	
end
