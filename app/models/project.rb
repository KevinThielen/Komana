class Project < ActiveRecord::Base

	has_many :lists, :dependent => :destroy
	has_and_belongs_to_many :users

	validates :name, presence: true, length: { minimum: 3 }
	
	
	def self.get_my_projects(user_id)
		my_projects = Project.joins(:users).where("user_id = ?", user_id)
		return my_projects
	end
	
	
	def get_last_updated

	 	@project = Project.find(id)
	 	last_updated_list = List.where("project_id = ?", id).order(:updated_at).first
	 	last_updated_lists_for_tasks = List.where("project_id = ?", id)

		 	last_updated_lists_for_tasks.each do |last_updated|

				 		last_updated_task = last_updated.tasks.order(:updated_at).first

				if last_updated_task.nil?
				
					elsif last_updated_task.updated_at >= last_updated_list.updated_at && last_updated_task.updated_at > @project.updated_at
					 	@project.updated_at = last_updated_task.updated_at
					end
				if last_updated_list.updated_at > @project.updated_at
				 		@project.updated_at = last_updated_list.updated_at
				end
			end
		return @project.updated_at
	end
	
end
