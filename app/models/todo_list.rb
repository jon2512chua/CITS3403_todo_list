class TodoList < ActiveRecord::Base
  has_and_belongs_to_many :users
  attr_accessible :name, :user_id
end
