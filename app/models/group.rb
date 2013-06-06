class Group < ActiveRecord::Base
  attr_accessible :desc, :name
  has_many :trackings
  has_many :users
end
