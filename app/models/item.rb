class Item < ActiveRecord::Base
  attr_accessible :desc, :name
  has_many :trackings, :dependent => :destroy

  validates :name, :presence => true

  after_initialize :default_values

  def default_values
    self.desc ||= ''
  end
end
