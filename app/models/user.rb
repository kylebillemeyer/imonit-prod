require 'valid_email/email_validator'

class User < ActiveRecord::Base
  include ActiveModel::Validations
  attr_accessible :email, :first, :last

  has_many :trackings, :foreign_key => "user_on_it_id", :dependent => :nullify
  has_many :tracking_subscriptions, :dependent => :destroy
  has_many :group_to_user, :dependent => :destroy
  has_many :groups, :through => :group_to_user  

  validates :email, :presence => true, :uniqueness => true, :email => true
  validates :first, :presence => true

  after_initialize :default_values

  def default_values
    self.last ||= ''
  end
end
