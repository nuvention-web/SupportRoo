class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.integer :user_id
      t.integer :task_id
      t.boolean :sent_by_us
      t.text :body

      t.timestamps null: false
    end
  end
end
