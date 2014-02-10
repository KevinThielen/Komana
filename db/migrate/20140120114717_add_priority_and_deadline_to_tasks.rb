class AddPriorityAndDeadlineToTasks < ActiveRecord::Migration
  def change
  	add_column :tasks, :priority, :integer
  	add_column :tasks, :deadline, :date
  end
end
