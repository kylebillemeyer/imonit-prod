class Group < ActiveRecord::Base
  attr_accessible :desc, :name
  has_many :trackings
  has_many :group_to_user
  has_many :users, :through => :group_to_user
end
