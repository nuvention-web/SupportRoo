class AddSupporterNameToTask < ActiveRecord::Migration
  def change
    add_column :tasks, :supporter_name, :string
  end
end
