class RemoveQuestionMarkFromCompletedOnTasks < ActiveRecord::Migration
  def self.up
    rename_column :tasks, :completed?, :completed
    rename_column :tasks, :pinned?, :pinned
  end

  def self.down
    rename_column :tasks, :completed, :completed?
    rename_column :tasks, :pinned, :pinned?
  end
end
