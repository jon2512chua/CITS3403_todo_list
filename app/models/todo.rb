class Todo < ActiveRecord::Base
  belongs_to :TodoList
  attr_accessible :completed, :content, :due_date, :user_id
end
