class AddSupportEmailToTask < ActiveRecord::Migration
  def change
    add_column :tasks, :supporter_email, :string
    add_column :tasks, :supporter_message, :string
  end
end
