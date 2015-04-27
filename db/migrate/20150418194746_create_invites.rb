class CreateInvites < ActiveRecord::Migration
  def change
    create_table :invites do |t|
      t.integer :board_id
      t.string :code
      t.boolean :claimed, default: false
      t.string :email, required: true

      t.timestamps null: false

    end
  
    add_index :invites, :code
  end
end
