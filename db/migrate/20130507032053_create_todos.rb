class CreateTodos < ActiveRecord::Migration
  def change
    create_table :todos do |t|
      t.string :content
      t.integer :user_id
      t.date :due_date
      t.boolean :completed

      t.timestamps
    end
    add_index :todos, [:user_id, :created_at]    
  end
end
