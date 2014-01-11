class ListsController < ApplicationController
  before_filter :authenticate_user!
	def create
		@project = Project.find(params[:project_id])
		@list = @project.lists.create(:name => "neue Liste")
		
		redirect_to project_path(@project)
	end
	
	def show	
		@list = List.find(params[:id])
		redirect_to project_path(@list.project_id)
	end
	
	def update

		@list = List.find(params[:id])
		@list_name = params[:list_name]
		@list.update!(:name => @list_name)
		
		redirect_to project_path(@list.project_id)
	end
	
	def destroy 
	   @project = Project.find(params[:project_id])
	   @list = List.find(params[:list_id])
	   @list.destroy
	   
	   redirect_to project_path(@project)
	end
end
