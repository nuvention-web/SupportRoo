class AddAttrsToSupporter < ActiveRecord::Migration
  def change
    add_column :supporters, :board_id, :int
    add_column :supporters, :user_id, :int
    add_column :supporters, :owner, :boolean
  end
end
