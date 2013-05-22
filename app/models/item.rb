class Item < ActiveRecord::Base
  attr_accessible :content, :name, :due_date
  belongs_to :user

  validates :content, length: { maximum: 140 }  
  validates :name, presence: true, length: { maximum: 80 } 
  validates :user_id, presence: true

  default_scope order: 'items.created_at DESC'  
end
