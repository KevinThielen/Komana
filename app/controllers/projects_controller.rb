# coding: UTF-8
class ProjectsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :check_auth, :only => [:destroy, :add_user]

 

  	def check_auth
  		@project = Project.find(params[:project_id])
 		project_user = ProjectsUsers.where("user_id =? and project_id=?", current_user, @project.id).first

  		if project_user.role != "author"
  			flash[:error] = "Für diesen Vorgang haben Sie keine Berechtigung."
  			redirect_to project_path(@project)
  		end
  	end

	def new 
		@project = Project.new
	end
	
	def create
		
		@project = Project.new(project_params)

			if @project.save	
				ProjectsUsers.addUserToProject(@project.id, current_user.id, "author")

				redirect_to project_path(@project)

		  	else 
		  		 @project.errors.full_messages_for(:name).each do |msg| 
    				 flash[:error] = msg
  				 end 
			  redirect_to new_project_path
  			end 
	end
	
	
	def add_user
		@project = Project.find(params[:project_id])
		@user = User.where("email = ?", params[:user_email]).first
		
		if @user.present? && @project.present?

			ProjectsUsers.addUserToProject(@project.id, @user.id, "member") 
			@user.notify("#{current_user.firstname} #{current_user.lastname} added you to Project \"#{@project.name}\"." , "added to Project" ).conversation

		else
			#TODO: error handling
			redirect_to project_path(@project)
			flash[:error] = "Dieser Benutzer existiert nicht, bitte prüfen sie ihre Eingabe"
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
	   @project = Project.find(params[:project_id])
	   @project.destroy
	   
	   redirect_to projects_path
	end
	
private
	def project_params
		params.require(:project).permit(:name)
	end
end
