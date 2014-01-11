class ProjectsController < ApplicationController
  before_filter :authenticate_user!
	def new 
		@project = Project.new
	end
	
	def create
		@project = Project.new(project_params)
		
	
		
		if @project.save	
			ProjectsUsers.addUserToProject(@project.id, current_user.id)

			redirect_to project_path(@project)
		else
			render 'new'
		end
	end
	
	def show
		@project = Project.find(params[:id])
		#used for the task modal.
		@current_task = Task.new
		@lists = @project.lists.find(:all)
	end
	
	def index
		@projects = Project.all
	end
	
	def destroy 
	   @project = Project.find(params[:id])
	   @project.destroy
	   
	   redirect_to projects_path
	end
	
private
	def project_params
		params.require(:project).permit(:name)
	end
end
