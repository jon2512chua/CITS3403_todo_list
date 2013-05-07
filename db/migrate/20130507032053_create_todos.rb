class CreateTodos < ActiveRecord::Migration
  def change
    create_table :todos do |t|
      t.string :content
      t.integer :user_id
      t.date :due_date
      t.boolean :completed

      t.timestamps
    end
  end
end
