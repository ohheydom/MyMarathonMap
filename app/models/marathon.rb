class Marathon < ActiveRecord::Base
  before_save :convert_time_to_seconds
  belongs_to :user
  attr_accessor :hour, :minute, :seconds

  def convert_time_to_seconds
    secs = 0
    secs += hour.to_i * 3600
    secs += minute.to_i * 60
    secs += seconds.to_i
    self.time = secs
  end
end
