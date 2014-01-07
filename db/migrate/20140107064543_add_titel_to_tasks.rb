class AddTitelToTasks < ActiveRecord::Migration
  def change
    add_column :tasks, :titel, :string
  end
end
