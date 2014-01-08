class TasksController < ApplicationController
  before_filter :authenticate_user!
	def create
		@list = List.find(params[:task][:list_id])
		@task = @list.tasks.create(params[:task].permit(:text))
		
		redirect_to project_path(@list.project)
	end
  
  def destroy 
	   @list = List.find(params[:task][:list_id])
	   @task = @list.tasks.find(params[:id])
	   @task.destroy
	end
	
	def move_to_next_list
		@task = Task.find(params[:task_id])
		@old_list = List.find(@task.list)
		
		@newList = List.where("id > ?",  @old_list.id).order("id ASC").first
		@newList.tasks << @task
		
		redirect_to project_path(params[:project_id])
	end
	
	def move_to_prev_list
		@task = Task.find(params[:task_id])
		@old_list = List.find(@task.list)
		
		@newList = List.where("id < ?",  @old_list.id).order("id ASC").last
		@newList.tasks << @task
		
		redirect_to project_path(params[:project_id])
	end
end
