class ListsController < ApplicationController
  before_filter :authenticate_user!
	def create
		@project = Project.find(params[:project_id])
		new_position = @project.lists.maximum(:position)
		
		if new_position.blank?
			new_position = 0
		end
		@list = @project.lists.create(:name => "neue Liste", :position => new_position+1)
		
		redirect_to project_path(@project)
	end
	
	def show	
		@list = List.find(params[:id])
		redirect_to project_path(@list.project_id)
	end
	
	def move_up
		list1 = List.find(params[:list_id])
		list2 = List.where("project_id = ? AND position > ?",  list1.project_id, list1.position).order("position ASC").first
		
		tmp_position = list1.position
		
		list1.update!(:position => list2.position)
		list2.update!(:position => tmp_position)
		
		redirect_to project_path(list1.project_id)
    end
    
  	def move_down
		list1 = List.find(params[:list_id])
		list2 = List.where("project_id = ? AND position < ?",  list1.project_id, list1.position).order("position DESC").first
		
		tmp_position = list1.position
		
		list1.update!(:position => list2.position)
		list2.update!(:position => tmp_position)
		
		redirect_to project_path(list1.project_id)
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

	   @project.updated_at = @list.updated_at
	   @project.save

	   @list.destroy
	   
	   redirect_to project_path(@project)
	end
end
