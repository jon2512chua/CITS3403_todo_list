class User < ActiveRecord::Base
  has_many :tweets
  attr_accessible :email, :name
end
