class Group < ActiveRecord::Base
  attr_accessible :desc, :name

  has_many :trackings, :dependent => :destroy
  has_many :group_to_user, :dependent => :destroy
  has_many :users, :through => :group_to_user

  validates :name, :presence => true

  after_initialize :default_values

  def default_values
    self.desc ||= ''
  end
end
