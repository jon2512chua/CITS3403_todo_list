class User < ActiveRecord::Base
  extend FriendlyId
  friendly_id :username, use: :slugged

  attr_accessible :username, :name, :email, :password, :password_confirmation
  has_secure_password
  has_many :items, dependent: :destroy

  before_save { |user| user.email = email.downcase }
  before_save :create_remember_token

  validates :username, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence:   true,
                    format:     { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  validates :password, presence: true, length: { minimum: 6 }
  validates :password_confirmation, presence: true
  
  # https://groups.google.com/forum/?fromgroups#!topic/whenever-gem/Ima-tvdqZds
  def self.send_reminder
    @user = User.all
    @user.each do |user|
      UserMailer.todo_today(user).deliver if user.items.any? {|item| item.due_date == Date.tomorrow }
    end
  end

  def to_param
    username
  end
  
  private

    def create_remember_token
      self.remember_token = SecureRandom.urlsafe_base64
    end
end
