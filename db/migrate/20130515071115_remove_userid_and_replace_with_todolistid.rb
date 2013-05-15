class RemoveUseridAndReplaceWithTodolistid < ActiveRecord::Migration
  def up
  	remove_column :todos, :user_id
  	add_column :todos, :todo_list_id, :integer
  end

  def down
  end
end
