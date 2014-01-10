class AddDescriptionToTasks < ActiveRecord::Migration
  def change
    add_column :tasks, :decription, :string
  end
end
