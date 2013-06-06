class User < ActiveRecord::Base
  attr_accessible :email, :first, :last
  has_many :groups
  has_many :tracking_subscriptions
  has_many :trackings
end
