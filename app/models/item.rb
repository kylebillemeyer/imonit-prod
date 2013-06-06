class Item < ActiveRecord::Base
  attr_accessible :desc, :name
  has_many :trackings
end
