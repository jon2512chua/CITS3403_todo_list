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
#

class User < ActiveRecord::Base
  attr_accessible :username, :name, :email, :password, :password_confirmation
  has_secure_password

  before_save { email.downcase! }
  before_save :create_remember_token
  
  #has_and_belongs_to_many :todolists 

  validates :username, :presence => true, :length => {:minimum => 3},
            :format => {:with => /^[a-z0-9_-]{3,16}$/}, 
            #usernames between 3 and 16 characters
            :uniqueness => true
  validates :name, :presence => true, :length => {:minimum => 2}
  validates :email, :presence => true, 
            :format => {:with => /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/}, 
            :uniqueness => { case_sensitive: false }
  validates :password, :length => { minimum: 6 }
  validates :password_confirmation, :presence => true
  private 
  def create_remember_token
    # Using self ensures that assignment sets the user’s remember_token so that 
    # it will be written to the database along with the other attributes when the user is saved.
    self.remember_token = SecureRandom.urlsafe_base64
  end    
end
