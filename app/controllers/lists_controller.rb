class ListsController < ApplicationController
  before_filter :authenticate_user!
	def create
		@project = Project.find(params[:project_id])
		@list = @project.lists.create(params[:list].permit(:name))
			redirect_to project_path(@project)
	end
	
	def show
		@list = List.find(params[:id])
		redirect_to project_path(@list.project_id)
	end
	
	def update
		raise
		@list = List.find(params[:id])
		@list_name = params[:list_name]
		@list.update!(list_name)
		
		redirect_to project_path(params[:project_id])
	end
	
	def destroy 
	   @project = Project.find(params[:project_id])
	   @list = List.find(params[:list_id])
	   @list.destroy
	   
	   redirect_to project_path(@project)
	end
end
