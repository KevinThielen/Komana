class Project < ActiveRecord::Base

	has_many :lists, :dependent => :destroy
	has_and_belongs_to_many :users

	validates :name, presence: true, length: { minimum: 5 }
	
	 #include PublicActivity::Model
	 #tracked

	 def get_last_updated

	 	last_updated_list = List.where("project_id = ?", id).order(updated_at).first
	 	last_updated_list_for_tasks = List.where("project_id = ?", id)

	 	last_updated_list_for_tasks.each do |last_updated|

		 		last_updated_task = last_updated.tasks.order(updated_at).first

		 	if last_updated_task.updated_at >= last_updated_list.updated_at
		 		@last_updated_project = last_updated_task.updated_at
		 	else
		 		@last_updated_project = last_updated_list.updated_at
		 	end
		end
	 	return @last_updated_project
	 end
end
