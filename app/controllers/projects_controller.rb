class ProjectsController < ApplicationController
	def new 
		@project = Project.new
	end
	
	def create
		@project = Project.new(project_params)
		if @project.save
			redirect_to @project
		else
			render 'new'
		end
	end
	
	def show
		@project = Project.find(params[:id])
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
