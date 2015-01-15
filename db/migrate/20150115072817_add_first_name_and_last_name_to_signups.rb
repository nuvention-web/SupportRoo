class AddFirstNameAndLastNameToSignups < ActiveRecord::Migration
  def change
    add_column :signups, :first_name, :string
    add_column :signups, :last_name, :string
  end
end
