class User < ActiveRecord::Base
  attr_accessible :email, :first, :last
  has_many :group_to_user
  has_many :groups, :through => :group_to_user
  has_many :tracking_subscriptions
  has_many :trackings, :foreign_key => "user_on_it_id"
end
