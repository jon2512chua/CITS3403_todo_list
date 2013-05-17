# == Schema Information
#
# Table name: todos
#
#  id         :integer          not null, primary key
#  content    :string(255)
#  due_date   :date
#  completed  :boolean
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :integer
#

class Todo < ActiveRecord::Base
  attr_accessible :completed, :content, :due_date	

  belongs_to :user

  validates :content, presence: true, length: { maximum: 50 }
  validates :due_date, presence: true

  # DESC is SQL for “descending”, i.e., in descending order from newest to oldest.
  default_scope order: 'todos.created_at DESC'
  
  def self.from_users_followed_by(user)
    followed_user_ids = user.followed_user_ids
    where("user_id IN (?) OR user_id = ?", followed_user_ids, user)
  end  
end
