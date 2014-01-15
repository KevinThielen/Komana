class ProjectsUsers < ActiveRecord::Base
	def self.addUserToProject(project_id, user_id)	
		if(ProjectsUsers.where(:project_id => project_id, :user_id => user_id).blank?)
			ProjectsUsers.create(:project_id => project_id, :user_id => user_id)
		end
	end	
end
