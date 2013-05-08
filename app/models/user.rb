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
#

class User < ActiveRecord::Base
  before_save { |user| user.email = email.downcase }
  
  has_and_belongs_to_many :todolists
  attr_accessible :email, :name, :password, :password_confirmation
  validates :name, :presence => true, :length => {:minimum => 2}
  validates :email, :presence => true, :format => {:with => /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/}, :uniqueness => { case_sensitive: false }
  validates :password, :presence => true, :length => { minimum: 6 }
  has_secure_password
  validates :password_confirmation, :presence => true
end
