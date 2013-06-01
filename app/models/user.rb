class User < ActiveRecord::Base
  attr_accessible :email, :first, :group_id, :last
end
