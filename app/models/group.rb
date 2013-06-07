class Group < ActiveRecord::Base
  attr_accessible :desc, :name
  has_many :trackings
  has_and_belongs_to_many :users
end
