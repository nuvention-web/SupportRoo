class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.string :description
      t.datetime :start_time
      t.datetime :end_time
      t.integer :task_type_id
      t.integer :board_id
      t.boolean :shared
      t.boolean :accepted

      t.timestamps null: false
    end
  end
end
