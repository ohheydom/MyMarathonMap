class User < ActiveRecord::Base
  include Authentication
  has_many :marathons
end
