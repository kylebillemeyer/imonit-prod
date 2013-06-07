class TrackingSubscription < ActiveRecord::Base
  attr_accessible :user_id, :tracking_id
  belongs_to :user
  belongs_to :tracking
end
