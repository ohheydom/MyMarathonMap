class TimeConverter
  attr_reader :seconds
  def initialize(seconds = 0)
    @seconds = seconds
  end

  def hours
    format '%02d', (seconds / 3600)
  end

  def minutes
    format '%02d', ((seconds % 3600) / 60)
  end

  def seconds_remaining
    format '%02d', (seconds % 60)
  end

  def seconds_to_s
    "#{hours}:#{minutes}:#{seconds_remaining}"
  end
end
