class CreateBoards < ActiveRecord::Migration
  def change
    create_table :boards do |t|
      t.string :email

      t.timestamps null: false
    end
  end
end
