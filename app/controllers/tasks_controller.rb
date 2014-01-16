class TasksController < ApplicationController
  before_filter :authenticate_user!
	
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
		@task = Task.find(params[:task][:id])
		
		@task.update!(task_params)
		redirect_to project_path(params[:project_id])	
	end
	
	def move_to_next_list
		@task = Task.find(params[:task_id])
		@old_list = List.find(@task.list)
		
		@newList = List.where("project_id = ? AND position > ?",  @old_list.project_id, @old_list.position).order("position ASC").first
		
		
		new_position = @newList.tasks.maximum(:position)
		if new_position.blank?
			new_position = 0
		end
		
		@task.position = new_position +1
		
		@newList.tasks << @task
		redirect_to project_path(params[:project_id])
	end
	
	def move_to_prev_list	
		@task = Task.find(params[:task_id])
		@old_list = List.find(@task.list)
		
		@newList = List.where("project_id = ? AND position < ?",  @old_list.project_id, @old_list.position).order("position DESC").first
		
		new_position = @newList.tasks.maximum(:position)
		if new_position.blank?
			new_position = 0
		end
		
		@task.position = new_position+1
		
		@newList.tasks << @task
		
		redirect_to project_path(params[:project_id])
	end
	
	def move_down
		task1 = Task.find(params[:task_id])
		task2 = Task.where("list_id = ? AND position < ?",  task1.list_id, task1.position).order("position DESC").first
		
		tmp_position = task1.position
		
		task1.update!(:position => task2.position)
		task2.update!(:position => tmp_position)
		
		redirect_to project_path(task1.list.project_id)
    end
    
    def move_up
		task1 = Task.find(params[:task_id])
		task2 = Task.where("list_id = ? AND position > ?",  task1.list_id, task1.position).order("position ASC").first
		
		raise if task1.blank? 
		raise if task2.blank? 
		
		tmp_position = task1.position
		
		task1.update!(:position => task2.position)
		task2.update!(:position => tmp_position)
		
		redirect_to project_path(task1.list.project_id)
	end
private
	def task_params
	  params.require(:task).permit(:titel, :text)
	end
end
