module ProjectsHelper
  
  def get_title_class(assigned_user)
    if assigned_user.present?
      return "task-title"
    else
      return "task-title-small"
    end
  end
end
