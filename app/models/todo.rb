# == Schema Information
#
# Table name: todos
#
#  id         :integer          not null, primary key
#  content    :string(255)
#  user_id    :integer
#  due_date   :date
#  completed  :boolean
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Todo < ActiveRecord::Base
  belongs_to :TodoList
  attr_accessible :completed, :content, :due_date, :user_id
  validates :completed, :presence => true
  validates :content, :presence => true
  validates :due_date, :presence => true
  validates :user_id, :presence => true
end
