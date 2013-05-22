class Item < ActiveRecord::Base
  attr_accessible :content, :name, :due_date
  belongs_to :user

  validates :content, length: { maximum: 140 }
  validates :name, presence: true, length: { maximum: 80 }
  validates :user_id, presence: true
  validate :due_date_cannot_be_in_the_past

  def due_date_cannot_be_in_the_past
    if !due_date.blank? and due_date < Date.today
      errors.add(:due_date, "can't be in the past")
    end
  end

  default_scope order: 'items.created_at DESC'
end
