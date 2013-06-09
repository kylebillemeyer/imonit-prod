class Tracking < ActiveRecord::Base
  attr_accessible :measurement, :remaining, :threshold, :group_id, :item_id, :user_on_it_id
  belongs_to :group
  belongs_to :item
  belongs_to :user_on_it, :class_name => 'User'
  has_many :tracking_subscriptions, :dependent => :destroy
end
