class User < ActiveRecord::Base
  attr_accessible :email, :first, :last
  has_and_belongs_to_many :groups
  has_many :tracking_subscriptions
  has_many :trackings, :foreign_key => "user_on_it_id"
end
