class AddDefaultValueForOwner < ActiveRecord::Migration
  def change
    change_column :supporters, :owner, :boolean, { default: false }
  end
end
