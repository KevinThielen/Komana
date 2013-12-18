class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.string :text
      t.integer :position
      t.references :list, index: true

      t.timestamps
    end
  end
end
