class AddDefaultValueToPinnedToTask < ActiveRecord::Migration
  def change
    change_column :tasks, :pinned?, :boolean, default: false
  end
end
