class Group < ActiveRecord::Base
  attr_accessible :desc, :name
  has_many :trackings, :dependent => :destroy
  has_many :group_to_user, :dependent => :destroy
  has_many :users, :through => :group_to_user
end
