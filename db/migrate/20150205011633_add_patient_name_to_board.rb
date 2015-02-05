class AddPatientNameToBoard < ActiveRecord::Migration
  def change
    add_column :boards, :patient_name, :string
  end
end
