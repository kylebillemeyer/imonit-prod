class Tracking < ActiveRecord::Base
  attr_accessible :measurement, :remaining, :threshold, :user_on_it
  belongs_to :group
  has_one :item
  has_one :user
  has_many :tracking_subscriptions
end
