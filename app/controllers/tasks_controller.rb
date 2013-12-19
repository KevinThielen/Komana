class TasksController < ApplicationController
	def create
		@list = List.find(params[:task][:list_id])
		@task = @list.tasks.create(params[:task].permit(:text))
			redirect_to project_path(@list.project)
	end
	
end
