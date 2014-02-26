class ProjectsUsers < ActiveRecord::Base
	
	validates :role, :inclusion => { :in => %w{author member guest} }

	def self.addUserToProject(project_id, user_id, role)	
		if(ProjectsUsers.where(:project_id => project_id, :user_id => user_id).blank?)
			ProjectsUsers.create(:project_id => project_id, :user_id => user_id, :role => role)
		end
	end

	def self.removeUserFromProject(project_id, user_id)
		@project_user = ProjectsUsers.where(:project_id => project_id, :user_id => user_id).first
		@project_user.destroy
		
		#deletes the project if there are no users
		if ProjectsUsers.where(:project_id => project_id,).count < 1
			Project.find(project_id).destroy
		end
	end
end
