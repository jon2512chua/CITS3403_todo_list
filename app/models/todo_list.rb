# == Schema Information
#
# Table name: todo_lists
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class TodoList < ActiveRecord::Base
  has_and_belongs_to_many :users #many to many relationship between todo_lists and users
  has_many :todos

  attr_accessible :name, :user_id
  validates :name, :presence => true, :uniqueness => true
  validates :user_id, :presence => true
end