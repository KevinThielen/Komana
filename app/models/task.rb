class Task < ActiveRecord::Base

  belongs_to :list
  has_and_belongs_to_many :users

  validates :titel, presence: true, length: { minimum: 3 }
  validates :text, length: { maximum: 512 }

	 

  validates :priority, :inclusion => { :in => %w{low medium high} }

  def self.get_my_tasks(user_id)
	my_tasks = Task.joins(:users).where("user_id = ?", user_id)
	return my_tasks
  end
  
  def self.get_urgent_tasks_count(user_id)
    count_urgent = 0
    @tasks = Task.where("priority = ?", "high")
    @tasks.each do |task|
      @project_user = ProjectsUsers.where("project_id = ?", task.list.project.id).where("user_id = ?", user_id).first
      if @project_user
        if user_id == @project_user.user_id
	      count_urgent = count_urgent + 1
        end
      end
    end	
    
    return count_urgent
  end
  
  def self.get_free_tasks(user_id)
    count_free = 0 
    @tasks = Task.includes(:users).where("users.id is NULL") 
    @tasks.each do |task| 
	  @project_user = ProjectsUsers.where("project_id = ?", task.list.project.id).where("user_id = ?", user_id).first 
	    if @project_user 
		  if user_id == @project_user.user_id 
		   count_free = count_free + 1 
		  end 
	    end 
    end 
    return count_free
  end
end
