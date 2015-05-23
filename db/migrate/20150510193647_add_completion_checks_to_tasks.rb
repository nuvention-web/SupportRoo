class AddCompletionChecksToTasks < ActiveRecord::Migration
  def change
    add_column :tasks, :completion_check, :boolean, default: false
    add_column :tasks, :completion_check_time, :datetime
  end
end
