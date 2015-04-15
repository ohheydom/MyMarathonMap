class User < ActiveRecord::Base
  include Authentication

  has_many :marathons
  has_many :states, through: :marathons
end
