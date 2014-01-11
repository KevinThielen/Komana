class ProjectsUsers < ActiveRecord::Base
	def self.addUserToProject(project_id, user_id)		
		ProjectsUsers.create(:project_id => project_id, :user_id => user_id)
	end	
end
