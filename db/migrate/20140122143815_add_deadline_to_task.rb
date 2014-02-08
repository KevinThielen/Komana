class AddDeadlineToTask < ActiveRecord::Migration
  def change
    add_column :tasks, :deadline, :date
  end
end
