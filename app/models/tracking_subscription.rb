class TrackingSubscription < ActiveRecord::Base
  # attr_accessible :title, :body
  belongs_to :user
  belongs_to :tracking
end
