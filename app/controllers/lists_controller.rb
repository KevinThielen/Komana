class ListsController < ApplicationController
	def create
		@project = Project.find(params[:project_id])
		@list = @project.lists.create(params[:list].permit(:name))
			redirect_to project_path(@project)
	end
end
