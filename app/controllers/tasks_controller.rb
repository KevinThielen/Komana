class TasksController < ApplicationController
  before_filter :authenticate_user!
	
	
	def search	
	 
	
	 if params[:partial]
		@partial = params[:partial]
	 else
		@partial = "tasks/assigned_tasks"
	 end
	 

   end
  
	def create
		@list = List.find(params[:list_id])
		new_position = @list.tasks.maximum(:position)
		
		if new_position.blank?
			new_position = 0
		end
		
		@task = @list.tasks.create(:titel => "neue Aufgabe", :text => "", :position => new_position+1)
		
		redirect_to project_path(@list.project)
	end
  
    def destroy 

	   @list = List.find(params[:list_id])
	   @task = @list.tasks.find(params[:task_id])
	   @task.destroy
	
	   redirect_to project_path(params[:project_id])
	end
	
	def update


		@task = Task.find(params[:task_id])
		@task.update!(:titel => params[:titel], :text=>params[:text])
		
		TasksUsers.assignUserToTask(@task.id, params[:user_id])
		
		
		redirect_to project_path(params[:project_id])	
	end
		
	def update_position
		moved_task = Task.find(params[:task_id])
		moved_to_list = List.find(params[:list_id])
		moved_to_position = params[:position]
		
		#check if there are other taks after this in the old list and reduce their positions by 1
		sibling_tasks = Task.where("list_id = ? and position > ?", moved_task.list, moved_task.position).order("position ASC")
		
		sibling_tasks.each do |t|
			old_position = t.position
			t.update!(:position => old_position-1)
		end
	
			
		if( moved_task.list.id != moved_to_list.id)
			#check if there are other taks after this and increase thei positions by 1
			
			new_sibling_tasks = Task.where("list_id = ? and position >= ?", moved_to_list.id, moved_to_position).order("position ASC")
			
			new_sibling_tasks.each do |t|
				old_position = t.position
				t.update!(:position => old_position+1)
			end
			
			moved_task.update!(:position => moved_to_position)
			moved_to_list.tasks << moved_task
		end
		
			
		redirect_to project_path(moved_to_list.project_id)
	end 
	
private
	def task_params
	  params.require(:task).permit(:titel, :text)
	end
end
