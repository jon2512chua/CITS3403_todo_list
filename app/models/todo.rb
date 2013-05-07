class Todo < ActiveRecord::Base
  belongs_to :TodoList
  attr_accessible :completed, :content, :due_date, :user_id
  validates :completed, :presence => true
  validates :content, :presence => true
  validates :due_date, :presence => true
  validates :user_id, :presence => true
end
