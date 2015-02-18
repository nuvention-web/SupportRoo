class AddCategoryToTaskType < ActiveRecord::Migration
  def change
    add_column :task_types, :category, :string
  end
end
