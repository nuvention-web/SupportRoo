class RenamePatientName < ActiveRecord::Migration
  def change
  	    remove_column :boards, :patient_name
	    add_column :boards, :name, :string
  end
end
