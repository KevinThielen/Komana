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
	
	
	def add_user
		@project = Project.find(params[:project_id])
		@user = User.where("email = ?", params[:user_email]).first
		
		if @user.present? && @project.present?
			ProjectsUsers.addUserToProject(@project.id, @user.id) 
			current_user.send_message(@user, "#{@user.firstname} #{@user.lastname} added you to Project #{@project.name}." , "added to Project" ).conversation
		else
			#TODO: error handling
			raise
		end
		redirect_to project_path(@project)
	end 
	
	def show
		@project = Project.find(params[:id])
		#used for the task modal.
		@current_task = Task.new
		@lists = List.where("project_id = ?",  @project.id).order("position ASC")
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
