class AddDefaultValueToTasks < ActiveRecord::Migration
  def change
    change_column :tasks, :pinned?, :boolean, { defualt: false }
  end
end
