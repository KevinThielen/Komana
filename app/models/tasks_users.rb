class TasksUsers < ActiveRecord::Base
include PublicActivity::Model
	 tracked
	def self.assignUserToTask(task_id, user_id)	
	
		#first remove relation if it exists
		if user_id.blank?
			TasksUsers.where(:task_id => task_id).destroy_all
		elsif(TasksUsers.where(:task_id => task_id).blank?)
			TasksUsers.create(:task_id => task_id, :user_id => user_id)
		else
			old_relation = TasksUsers.where(:task_id => task_id).first
			old_relation.update!(:user_id => user_id)
		end
	end
	
end
