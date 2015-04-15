class State < ActiveRecord::Base
  has_many :marathons
  has_many :users, through: :marathons

  validates :state, uniqueness: true
end
