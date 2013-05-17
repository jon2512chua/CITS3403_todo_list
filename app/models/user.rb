# == Schema Information
#
# Table name: users
#
#  id                    :integer          not null, primary key
#  name                  :string(255)
#  email                 :string(255)
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#  password_digest       :string(255)
#  password              :string(255)
#  password_confirmation :string(255)
#  username              :string(255)
#  remember_token        :string(255)
#

class User < ActiveRecord::Base
  attr_accessible :username, :name, :email, :password, :password_confirmation
  has_secure_password
  # arranges for the dependent todos (i.e., the ones belonging to the given user) 
  # to be destroyed when the user itself is destroyed. 
  has_many :todos, dependent: :destroy
  has_many :relationships, foreign_key: "follower_id", dependent: :destroy 
  has_many :followed_users, through: :relationships, source: :followed  
  has_many :reverse_relationships, foreign_key: "followed_id",
                                   class_name:  "Relationship",
                                   dependent:   :destroy
  has_many :followers, through: :reverse_relationships, source: :follower  

  before_save { email.downcase! }
  before_save :create_remember_token
  
  validates :username, presence: true, length: {minimum: 2},
            format: {with: /^[a-z0-9_-]{3,16}$/}, 
            #usernames between 3 and 16 characters
            uniqueness: true
  validates :name, presence: true, length: { minimum: 2, maximum: 50 }
  validates :email, presence: true, 
            format: {with: /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/}, 
            uniqueness: { case_sensitive: false }
  validates :password, length: { minimum: 6 }
  validates :password_confirmation, presence: true
  def feed
    # This is preliminary. See "Following users" for the full implementation.
    # '?' ensures that id is properly escaped before being included in the underlying SQL query, thereby avoiding a serious security hole called SQL injection.
    # Todo.where("user_id = ?", id)

    # previous equal to:
    #todos

    Todo.from_users_followed_by(self)   
  end 

  def following?(other_user)
    relationships.find_by_followed_id(other_user.id)
  end

  def follow!(other_user)
    relationships.create!(followed_id: other_user.id)
  end

  def unfollow!(other_user)
    relationships.find_by_followed_id(other_user.id).destroy
  end  

  private 
    def create_remember_token
      # Using self ensures that assignment sets the user’s remember_token so that 
      # it will be written to the database along with the other attributes when the user is saved.
      self.remember_token = SecureRandom.urlsafe_base64
    end    
end
